import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/auth/state/steam_state.dart';
import 'package:observatory/shared/constans.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/models/history.dart';
import 'package:observatory/shared/models/info.dart';
import 'package:observatory/shared/models/itad_filters.dart';
import 'package:observatory/shared/models/overview.dart';
import 'package:observatory/shared/models/price.dart';
import 'package:observatory/shared/models/store.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class API {
  final Dio dio = Dio(BaseOptions(responseType: ResponseType.plain));
  final SettingsRepository settingsReporsitory = GetIt.I<SettingsRepository>();

  Future<Info?> info({
    required String id,
  }) async {
    try {
      final FunctionResponse info =
          await Supabase.instance.client.functions.invoke(
        'itad-api/info',
        method: HttpMethod.get,
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
      final FunctionResponse overview =
          await Supabase.instance.client.functions.invoke(
        'itad-api/overview',
        method: HttpMethod.post,
        body: ids,
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

  Future<Map<String, List<Price>?>> prices({
    required List<String> ids,
  }) async {
    final String country = await settingsReporsitory.getCountry();
    final List<int> stores = await settingsReporsitory.getSelectedStores();

    try {
      final FunctionResponse prices =
          await Supabase.instance.client.functions.invoke(
        'itad-api/prices',
        method: HttpMethod.post,
        queryParameters: {
          'country': country,
          'shops': stores.join(','),
          'deals': 'false',
          'vouchers': 'true',
          'capacity': '0',
        },
        body: ids,
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
    final DefaultCacheManager cacheManager = DefaultCacheManager();
    final String country = await settingsReporsitory.getCountry();

    final String cacheKey = 'stores-$country';
    final FileInfo? file = await cacheManager.getFileFromCache(
      cacheKey,
    );

    if (file != null) {
      return json
          .decode(
            utf8.decode(file.file.readAsStringSync().codeUnits),
          )
          .map<Store>((e) => Store.fromJson(e))
          .toList();
    }

    final FunctionResponse stores =
        await Supabase.instance.client.functions.invoke(
      'itad-api/stores',
      method: HttpMethod.get,
      queryParameters: {
        'country': country,
      },
    );

    await cacheManager.putFile(
      cacheKey,
      utf8.encode(json.encode(stores.data)),
      maxAge: const Duration(days: 7),
    );

    return stores.data.map<Store>((e) => Store.fromJson(e)).toList();
  }

  Future<List<Deal>> fetchDeals({
    final int limit = DEALS_COUNT,
    final int offset = 0,
  }) async {
    final String country = await settingsReporsitory.getCountry();
    final List<int> stores = await settingsReporsitory.getSelectedStores();
    final ITADFilters filters = settingsReporsitory.getITADFilters();

    final FunctionResponse response =
        await Supabase.instance.client.functions.invoke(
      'itad-api/deals',
      method: HttpMethod.get,
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

  Future<List<Deal>> getDealsBySteamIds(
    List<Deal> deals,
  ) async {
    final List<Store> allStores = await stores();
    final int steamStoreId = allStores
        .firstWhere(
          (e) => e.title == 'Steam',
        )
        .id;
    final List<String?> steamAppIds = deals
        .map(
          (e) => e.steamId,
        )
        .whereType<String>()
        .toList();

    final response = await dio.post(
      Uri.https(BASE_URL, '/lookup/id/shop/$steamStoreId/v1', {
        'key': API_KEY,
      }).toString(),
      data: json.encode(steamAppIds),
    );

    final Map<String, dynamic> idsMap = json.decode(response.toString());

    return deals
        .map(
          (e) => e.copyWith(id: idsMap[e.steamId] ?? 'none'),
        )
        .where((e) => e.id != 'none')
        .toList();
  }

  Future<List<Deal>> getByAppIDs(List<Deal> deals) async {
    final List<Deal> foundDeals = await getDealsBySteamIds(deals);

    return fetchDealData(
      deals: foundDeals,
    );
  }

  Future<List<Deal>> fetchSteamWishlist(String steamId) async {
    final Map<String, dynamic> results = {};

    for (int i = 0; i < MAX_STEAM_WISHLIST_PAGES; i++) {
      final Uri steamAPI = Uri.https(
        'store.steampowered.com',
        '/wishlist/profiles/$steamId/wishlistdata/',
        {'p': '$i'},
      );
      final steamResponse = await dio.get(steamAPI.toString());
      final response = json.decode(steamResponse.toString());

      if (response is List) {
        break;
      }

      results.addAll(response);
    }

    return results.entries
        .map(
          (e) => Deal(
            id: 'none',
            title: e.value['name'],
            steamId: 'app/${e.key}',
            added: (e.value['added'] ?? 0) * 1000,
            source: DealSource.steam,
          ),
        )
        .toList();
  }

  Future<List<Deal>> fetchSteamLibrary(String steamId) async {
    final FunctionResponse steamLibrary =
        await Supabase.instance.client.functions.invoke(
      'steam-api/library',
      method: HttpMethod.get,
      queryParameters: {
        'steamid': steamId,
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
    final FunctionResponse steamUser =
        await Supabase.instance.client.functions.invoke(
      'steam-api/user',
      method: HttpMethod.get,
      queryParameters: {
        'steamid': steamId,
      },
    );

    return SteamUser.fromJson(steamUser.data);
  }

  Future<List<Deal>> fetchDealData({
    required List<Deal> deals,
  }) async {
    if (deals.isEmpty) {
      return [];
    }

    final List<String> ids = deals.map((e) => e.id).toList();
    final Map<String, List<Price>?> listOfPrices = await prices(ids: ids);

    return deals.map(
      (deal) {
        return deal.copyWith(
          prices: listOfPrices[deal.id] ?? [],
        );
      },
    ).toList();
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

  Future<List<Deal>> getSearchResults({
    required final String query,
  }) async {
    final Uri url = Uri.https(BASE_URL, '/games/search/v1', {
      'key': API_KEY,
      'title': query.toString(),
      'results': 30.toString(),
    });

    final response = await dio.get(url.toString());
    final List<Deal> deals = json
        .decode(response.toString())
        .map<Deal>((deal) => Deal.fromJson(deal))
        .toList();

    return fetchDealData(deals: deals);
  }

  Future<List<History>> history({
    required String id,
  }) async {
    try {
      final List<int> stores = await settingsReporsitory.getSelectedStores();
      final String country = await settingsReporsitory.getCountry();

      final FunctionResponse history =
          await Supabase.instance.client.functions.invoke(
        'itad-api/history',
        method: HttpMethod.get,
        queryParameters: {
          'id': id,
          'country': country,
          'shops': stores.join(','),
        },
      );

      return history.data.map<History>((e) => History.fromJson(e)).toList();
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
