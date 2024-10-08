import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:observatory/secret_loader.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/auth/state/steam_state.dart';
import 'package:observatory/shared/api/constans.dart';
import 'package:observatory/shared/api/parsers.dart';
import 'package:observatory/shared/api/utils.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/models/history.dart';
import 'package:observatory/shared/models/info.dart';
import 'package:observatory/shared/models/itad_filters.dart';
import 'package:observatory/shared/models/overview.dart';
import 'package:observatory/shared/models/price.dart';
import 'package:observatory/shared/models/steam_featured_item.dart';
import 'package:observatory/shared/models/store.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

class API {
  final Dio dio;
  final CacheOptions cacheOptions;
  final SettingsRepository settingsReporsitory = GetIt.I<SettingsRepository>();

  API({
    required this.dio,
    required this.cacheOptions,
  });

  static API create(String? directory) {
    final options = CacheOptions(
      store: HiveCacheStore(directory),
      policy: CachePolicy.noCache,
      maxStale: const Duration(days: 14),
    );

    return API(
      dio: Dio(BaseOptions(responseType: ResponseType.plain))
        ..interceptors.add(DioCacheInterceptor(options: options)),
      cacheOptions: options,
    );
  }

  Future<Info?> info({
    required String id,
  }) async {
    try {
      final Uri url = Uri.https(BASE_URL, '/games/info/v2', {
        'key': API_KEY,
        'id': id,
      });

      return Parsers.info(await dio.get(url.toString()));
    } catch (error, stackTrace) {
      Logger().e(
        'Failed to fetch info',
        error: error,
      );

      FirebaseCrashlytics.instance.recordError(
        error,
        stackTrace,
      );

      return null;
    }
  }

  Future<Overview?> overview({
    required List<String> ids,
  }) async {
    final String country = await settingsReporsitory.getCountry();

    try {
      final Uri url = Uri.https(BASE_URL, '/games/overview/v2', {
        'key': API_KEY,
        'country': country,
      });

      final response = await dio.post(
        url.toString(),
        data: json.encode(ids),
      );

      return Parsers.overview(response);
    } catch (error, stackTrace) {
      Logger().e(
        'Failed to fetch overview',
        error: error,
      );

      FirebaseCrashlytics.instance.recordError(
        error,
        stackTrace,
      );

      return null;
    }
  }

  Future<Map<String, List<Price>?>> prices({
    required List<String> ids,
  }) async {
    final String country = await settingsReporsitory.getCountry();
    final List<int> stores = await settingsReporsitory.getSelectedStores();

    final Map<String, List<Price>> prices = {};
    final List<List<String>> listOfIds = splitIDs(ids);

    for (List<String> list in listOfIds) {
      try {
        final Uri url = Uri.https(BASE_URL, '/games/prices/v3', {
          'key': API_KEY,
          'country': country,
          'shops': stores.join(','),
          'deals': 'false',
          'vouchers': 'true',
          'capacity': '0',
        });

        final response = await dio.post(
          url.toString(),
          data: json.encode(list),
        );

        prices.addAll(Parsers.prices(response));
      } catch (error, stackTrace) {
        Logger().e(
          'Failed to fetch prices',
          error: error,
        );

        FirebaseCrashlytics.instance.recordError(
          error,
          stackTrace,
        );
      }
    }

    return prices;
  }

  Future<List<Store>> stores() async {
    final String country = await settingsReporsitory.getCountry();

    final Uri url = Uri.https(BASE_URL, '/service/shops/v1', {
      'key': API_KEY,
      'country': country,
    });

    final stores = await dio.get(
      url.toString(),
      options: cacheOptions
          .copyWith(
            policy: CachePolicy.forceCache,
          )
          .toOptions(),
    );

    return Parsers.stores(stores);
  }

  Future<List<Deal>> fetchDeals({
    final int limit = DEALS_COUNT,
    final int offset = 0,
  }) async {
    final String country = await settingsReporsitory.getCountry();
    final List<int> stores = await settingsReporsitory.getSelectedStores();
    final ITADFilters filters = settingsReporsitory.getITADFilters();

    final Uri url = Uri.https(BASE_URL, '/deals/v2', {
      'key': API_KEY,
      'limit': limit.toString(),
      'offset': offset.toString(),
      'country': country,
      'shops': stores.join(','),
      'nondeals': filters.nondeals.toString(),
      'mature': filters.mature.toString(),
      'sort': '-trending',
      'filter': filters.filtersString,
    });

    final response = await dio.get(url.toString());

    return fetchDealData(deals: Parsers.deals(response));
  }

  Future<List<Deal>> fetchSteamTopSellers() async {
    final Uri steamAPI = Uri.https(
      'store.steampowered.com',
      '/api/featuredcategories',
    );
    final steamResponse = await dio.get(steamAPI.toString());
    final List<SteamFeaturedItem> topSellers = Parsers.steamStoreFront(
      steamResponse,
    );
    final List<Deal> steamDeals = topSellers
        .map(
          (e) => Deal(
            id: 'none',
            steamId: 'app/${e.id}',
            title: e.name,
          ),
        )
        .toList();

    return getByAppIDs(steamDeals);
  }

  Future<List<Deal>> gameIdsBySteamIds(
    List<Deal> deals,
  ) async {
    final List<Store> allStores = await stores();
    final int steamStoreId = allStores
        .firstWhere(
          (e) => e.title == 'Steam',
        )
        .id;
    final Uri url = Uri.https(BASE_URL, '/lookup/id/shop/$steamStoreId/v1', {
      'key': API_KEY,
    });
    final List<String?> steamAppIds = deals
        .map(
          (e) => e.steamId,
        )
        .whereType<String>()
        .toList();

    final response = await dio.post(
      url.toString(),
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
    final List<Deal> foundDeals = await gameIdsBySteamIds(deals);

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

  Future<SteamUser> fetchSteamUser(String steamId) async {
    final Uri steamAPI = Uri.https(
      'api.steampowered.com',
      '/ISteamUser/GetPlayerSummaries/v0002/',
      {
        'key': GetIt.I<Secret>().steamAPIKey,
        'steamids': steamId,
      },
    );
    final steamResponse = await dio.get(steamAPI.toString());

    return SteamUser.fromJson(
      json.decode(steamResponse.toString())['response']['players'][0],
    );
  }

  Future<List<Deal>> fetchSteamFeatured() async {
    final Uri steamAPI = Uri.https(
      'store.steampowered.com',
      '/api/featured',
    );
    final steamResponse = await dio.get(steamAPI.toString());
    final List<SteamFeaturedItem> topSellers = Parsers.steamFeatured(
      steamResponse,
    );
    final List<Deal> deals = topSellers
        .map(
          (e) => Deal(
            id: 'none',
            steamId: 'app/${e.id}',
            title: e.name,
          ),
        )
        .toList();

    return getByAppIDs(deals);
  }

  Future<List<Deal>> fetchDealsCategory({
    final int limit = DEALS_COUNT,
    final int offset = 0,
    final DealCategory category = DealCategory.all,
  }) async {
    final Uri url = Uri.https(
      BASE_URL,
      '/v01/stats/${category.name.toString()}/chart/',
      {
        'key': API_KEY,
        'limit': limit.toString(),
        'offset': offset.toString(),
      },
    );

    final response = await dio.get(url.toString());
    final List<Deal> deals = Parsers.popularityChart(response)
        .map(
          (e) => Deal(id: e.id),
        )
        .toList();

    return fetchDealData(deals: deals);
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
    final int limit = 20,
    final int offset = 0,
  }) async {
    final Uri url = Uri.https(BASE_URL, '/games/search/v1', {
      'key': API_KEY,
      'title': query.toString(),
      'results': 30.toString(),
    });

    final response = await dio.get(url.toString());
    final List<Deal> deals = Parsers.searchResults(response);

    return fetchDealData(deals: deals);
  }

  Future<Map<String, dynamic>?> lookupSteamIds({
    required List<String> ids,
  }) async {
    try {
      final Uri url = Uri.https(BASE_URL, '/unstable/id-lookup/steam/v1', {
        'key': API_KEY,
      });

      final response = await dio.post(url.toString(), data: json.encode(ids));

      return json.decode(response.toString());
    } catch (error, stackTrace) {
      Logger().e(
        'Failed to fetch steam ID mappings',
        error: error,
      );

      FirebaseCrashlytics.instance.recordError(
        error,
        stackTrace,
      );

      return null;
    }
  }

  Future<List<History>?> history({
    required String id,
  }) async {
    try {
      final List<int> stores = await settingsReporsitory.getSelectedStores();
      final String country = await settingsReporsitory.getCountry();

      final Uri url = Uri.https(BASE_URL, '/games/history/v2', {
        'key': API_KEY,
        'id': id,
        'shops': stores.join(','),
        'country': country,
      });

      return Parsers.history(await dio.get(url.toString()));
    } catch (error, stackTrace) {
      Logger().e(
        'Failed to fetch history',
        error: error,
      );

      FirebaseCrashlytics.instance.recordError(
        error,
        stackTrace,
      );

      return null;
    }
  }
}
