import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/auth/state/steam_state.dart';
import 'package:observatory/shared/constans.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/models/game/game.dart';
import 'package:observatory/shared/models/history.dart';
import 'package:observatory/shared/models/info.dart';
import 'package:observatory/shared/models/itad_filters.dart';
import 'package:observatory/shared/models/overview.dart';
import 'package:observatory/shared/models/price.dart';
import 'package:observatory/shared/models/store.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<dynamic> wrapCache(
  Function func, {
  String cacheKey = '',
  Duration maxAge = const Duration(days: 7),
}) async {
  final DefaultCacheManager cacheManager = DefaultCacheManager();
  final FileInfo? file = await cacheManager.getFileFromCache(
    cacheKey,
  );

  if (file != null) {
    return json.decode(
      utf8.decode(
        file.file.readAsBytesSync(),
        allowMalformed: true,
      ),
    );
  }

  final Response response = await func();

  if (response.data != null) {
    await cacheManager.putFile(
      cacheKey,
      response.data,
      maxAge: maxAge,
    );

    return json.decode(utf8.decode(response.data));
  }

  return null;
}

final BaseOptions options = BaseOptions(
  responseType: ResponseType.json,
  baseUrl: 'https://getobservatory.app/api/v1/',
  headers: {
    'Authorization':
        'Bearer ${dotenv.maybeGet('OBSERVATORY_API_KEY') ?? dotenv.maybeGet('OBSERVATORY_DEV_API_KEY')}',
  },
);

class API {
  final SettingsRepository settingsReporsitory = GetIt.I<SettingsRepository>();
  final Dio observatoryAPI = Dio(options);

  Future<Info?> info({
    required String id,
  }) async {
    try {
      final Response info = await observatoryAPI.get(
        '/itad-api/info',
        queryParameters: {
          'id': id,
        },
      );

      return Info.fromJson(info.data);
    } catch (error, stackTrace) {
      Logger().e(
        'Failed to fetch info',
        error: error,
      );

      Sentry.captureException(
        error,
        stackTrace: stackTrace,
      );

      return null;
    }
  }

  Future<Overview?> overview({
    required List<String> ids,
  }) async {
    try {
      final Response overview = await observatoryAPI.post(
        '/itad-api/overview',
        data: json.encode(ids),
      );

      return Overview.fromJson(overview.data);
    } catch (error, stackTrace) {
      Logger().e(
        'Failed to fetch overview',
        error: error,
      );

      Sentry.captureException(
        error,
        stackTrace: stackTrace,
      );

      return null;
    }
  }

  Future<GameDetails?> gameDetails({
    required String id,
    required String title,
  }) async {
    try {
      final details = await wrapCache(
        () => observatoryAPI.get(
          '/game-info',
          queryParameters: {
            'id': id,
            'title': title,
          },
          options: Options(
            responseType: ResponseType.bytes,
          ),
        ),
        cacheKey: 'game-info-$id',
      );

      return GameDetails.fromJson(details['data']);
    } catch (error, stackTrace) {
      Logger().e(
        'Failed to fetch game details',
        error: error,
      );

      Sentry.captureException(
        error,
        stackTrace: stackTrace,
      );

      return null;
    }
  }

  Future<Map<String, List<Price>?>> prices({
    required List<String> ids,
  }) async {
    final String country = await settingsReporsitory.getCountry();
    final List<int> stores = await settingsReporsitory.getSelectedStores();

    try {
      final Response prices = await observatoryAPI.post(
        '/itad-api/prices',
        queryParameters: {
          'country': country,
          'shops': stores.join(','),
          'deals': 'false',
          'vouchers': 'true',
          'capacity': '0',
        },
        data: json.encode(ids),
      );

      return prices.data.map<String, List<Price>?>(
        (String key, value) {
          return MapEntry<String, List<Price>?>(
            key,
            (value['deals'] ?? [])
                .map<Price>(
                  (price) => Price.fromJson(price).copyWith(
                    timestampMs: DateTime.tryParse(
                      price['timestamp'],
                    )?.millisecondsSinceEpoch,
                  ),
                )
                .toList(),
          );
        },
      );
    } catch (error, stackTrace) {
      Logger().e(
        'Failed to fetch prices',
        error: error,
      );

      Sentry.captureException(
        error,
        stackTrace: stackTrace,
      );

      return {};
    }
  }

  Future<List<Store>> stores() async {
    final String country = await settingsReporsitory.getCountry();

    final stores = await wrapCache(
      () => observatoryAPI.get(
        '/itad-api/stores',
        queryParameters: {
          'country': country,
        },
        options: Options(
          responseType: ResponseType.bytes,
        ),
      ),
      cacheKey: 'stores-$country',
    );

    return stores.map<Store>((e) => Store.fromJson(e)).toList();
  }

  Future<List<Deal>> fetchDeals({
    final int limit = DEALS_COUNT,
    final int offset = 0,
  }) async {
    final String country = await settingsReporsitory.getCountry();
    final List<int> stores = await settingsReporsitory.getSelectedStores();
    final ITADFilters filters = settingsReporsitory.getITADFilters();

    final Response response = await observatoryAPI.get(
      '/itad-api/deals',
      queryParameters: {
        'limit': limit.toString(),
        'offset': offset.toString(),
        'country': country,
        'shops': stores.join(','),
        'nondeals': filters.nondeals.toString(),
        'mature': filters.mature.toString(),
        'sort': SORT_BY_FILTER_STRINGS[SortDealsBy.values
            .byName(filters.sortBy ?? SortDealsBy.trending.name)],
        'filter': filters.filtersString,
        'include_prices': 'true',
        'deals': 'false',
        'vouchers': 'true',
      },
    );

    return response.data.map<Deal>((deal) => Deal.fromJson(deal)).toList();
  }

  Future<int> getSteamStoreId() async {
    final List<Store> allStores = await stores();

    return allStores
        .firstWhere(
          (e) => e.title == 'Steam',
        )
        .id;
  }

  Future<List<Deal>> fetchSteamWishlist(String steamId) async {
    final Response wishlist = await observatoryAPI.get(
      '/steam-api/wishlist',
      queryParameters: {
        'steamid': steamId,
        'shopId': await getSteamStoreId(),
      },
    );

    return wishlist.data.map<Deal>((deal) => Deal.fromJson(deal)).toList();
  }

  Future<List<Deal>> fetchSteamLibrary(String steamId) async {
    final Response steamLibrary = await observatoryAPI.get(
      '/steam-api/library',
      queryParameters: {
        'steamid': steamId,
        'shopId': await getSteamStoreId(),
      },
    );

    return steamLibrary.data
        .map<Deal>(
          (e) => Deal(
            id: 'none',
            title: e['name'],
            steamId: 'app/${e['appid']}',
            source: DealSource.steam,
          ),
        )
        .toList();
  }

  Future<SteamUser> fetchSteamUser(String steamId) async {
    final Response steamUser = await observatoryAPI.get(
      '/steam-api/user',
      queryParameters: {
        'steamid': steamId,
      },
    );

    return SteamUser.fromJson(steamUser.data);
  }

  Future<List<Deal>> fetchWaitlist() async {
    final List<Deal> deals = settingsReporsitory.getWaitlistDeals();
    final List<String> ids = deals.map((e) => e.id).toList();

    if (ids.isEmpty) {
      return [];
    }

    final Map<String, List<Price>?> mapOfPrices = await prices(ids: ids);

    return deals.map(
      (deal) {
        return deal.copyWith(
          prices: mapOfPrices[deal.id] ?? [],
        );
      },
    ).toList();
  }

  Future<List<Deal>> search({
    required final String query,
  }) async {
    final String country = await settingsReporsitory.getCountry();
    final List<int> stores = await settingsReporsitory.getSelectedStores();

    final Response searchResults = await observatoryAPI.get(
      '/itad-api/search',
      queryParameters: {
        'country': country,
        'shops': stores.join(','),
        'deals': 'false',
        'vouchers': 'true',
        'capacity': '0',
        'query': query,
      },
    );

    return searchResults.data.map<Deal>((deal) => Deal.fromJson(deal)).toList();
  }

  Future<List<History>> history({
    required String id,
  }) async {
    try {
      final List<int> stores = await settingsReporsitory.getSelectedStores();
      final String country = await settingsReporsitory.getCountry();

      final history = await wrapCache(
        () => observatoryAPI.get(
          '/itad-api/history',
          queryParameters: {
            'id': id,
            'country': country,
            'shops': stores.join(','),
          },
          options: Options(
            responseType: ResponseType.bytes,
          ),
        ),
        cacheKey: 'history-$id',
        maxAge: Duration(days: 1),
      );

      return history.map<History>((e) => History.fromJson(e)).toList();
    } catch (error, stackTrace) {
      Logger().e(
        'Failed to fetch history',
        error: error,
      );

      Sentry.captureException(
        error,
        stackTrace: stackTrace,
      );

      return [];
    }
  }
}
