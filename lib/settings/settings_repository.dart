import 'dart:async';
import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:logger/logger.dart';
import 'package:observatory/auth/state/itad_state.dart';
import 'package:observatory/auth/state/steam_state.dart';
import 'package:observatory/shared/constans.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/models/game/game.dart';
import 'package:observatory/shared/models/itad_filters.dart';
import 'package:observatory/shared/models/observatory_theme.dart';
import 'package:observatory/shared/models/price.dart';
import 'package:observatory/shared/models/shop.dart';

const SETTINGS_BOX_NAME = 'observatory_user_data';
const SAVED_DEALS_BOX_NAME = 'observatory_saved_deals';
const BOOKMARKED_DEALS_BOX_NAME = 'observatory_bookmarked_deals';
const PAST_SAVED_DEALS_BOX_NAME = 'observatory_past_saved_deals';
const RECENT_SEARCHES_BOX_NAME = 'observatory_recent_searches';
const ITAD_USER_BOX_NAME = 'itad_user';
const LIBRARY_BOX_NAME = 'observatory_library';

const ITAD_SECURE_KEY = 'itadSecureKey';

enum WaitlistSorting {
  title,
  date_added,
  price_cut,
  discount_date,
  price,
}

enum WaitlistSortingDirection { asc, desc }

class SettingsRepository {
  final Box settingsBox = Hive.box(SETTINGS_BOX_NAME);
  final Box<Deal> savedDealsBox = Hive.box<Deal>(
    SAVED_DEALS_BOX_NAME,
  );
  final Box<Deal> bookmarkedDealsBox = Hive.box<Deal>(
    BOOKMARKED_DEALS_BOX_NAME,
  );
  final Box<Deal> pastSavedDealsBox = Hive.box<Deal>(
    PAST_SAVED_DEALS_BOX_NAME,
  );
  final Box<String> recentSearchesBox = Hive.box<String>(
    RECENT_SEARCHES_BOX_NAME,
  );
  final Box<ITADUser?> itadUserBox = Hive.box<ITADUser?>(
    ITAD_USER_BOX_NAME,
  );
  final Box<Deal> libraryBox = Hive.box<Deal>(
    LIBRARY_BOX_NAME,
  );

  final String PREF_COUNTRY = 'observatory_default_country';
  final String PREF_CURRENCY = 'observatory_default_currency';
  final String PREF_SHOW_HEADERS = 'observatory_show_headers';
  final String PREF_SELECTED_STORES = 'observatory_selected_stores';
  final String PREF_DEALS_TAB = 'observatory_deals_tab_name';
  final String PREF_DEAL_CARD_TYPE = 'observatory_deal_card_type';
  final String PREF_THEME = 'observatory_theme';
  final String PREF_WAITLIST_NOTIFICATIONS =
      'observatory_waitlist_notifications';
  final String PREF_WAITLIST_SORTING = 'observatory_waitlist_sorting';
  final String PREF_WAITLIST_SORTING_DIRECTION =
      'observatory_waitlist_sorting_direction';
  final String PREF_STEAM_USERNAME = 'observatory_steam_username';
  final String PREF_STEAM_USER = 'observatory_steam_user';
  final String PREF_IGDB_ACCESS_TOKEN = 'observatory_igdb_access_token';
  final String PREF_ITAD_FILTERS = 'observatory_itad_filters';
  final String PREF_LAUNCH_COUNTER = 'observatory_launch_counter';
  final String PREF_PURCHASED_PRODUCTS = 'observatory_purchased_products';
  final String PREF_COLLAPSE_PINNED = 'observatory_collapse_pinned';
  final String PREF_MUTE_GAMES_IN_LIBRARY = 'observatory_mute_games_in_library';

  final WaitlistSorting defaultWaitlistSorting = WaitlistSorting.discount_date;
  final WaitlistSortingDirection defaultWaitlistSortingDirection =
      WaitlistSortingDirection.asc;

  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(ShopAdapter());
    Hive.registerAdapter(PriceDetailsAdapter());
    Hive.registerAdapter(PriceAdapter());
    Hive.registerAdapter(DealSourceAdapter());
    Hive.registerAdapter(DealAdapter());
    Hive.registerAdapter(ObservatoryThemeAdapter());
    Hive.registerAdapter(IGDBAccessTokenAdapter());
    Hive.registerAdapter(MinMaxAdapter());
    Hive.registerAdapter(ITADFiltersAdapter());
    Hive.registerAdapter(SteamUserAdapter());
    Hive.registerAdapter(ITADUserAdapter());

    await Hive.openBox(SETTINGS_BOX_NAME);
    await Hive.openBox<Deal>(SAVED_DEALS_BOX_NAME);
    await Hive.openBox<Deal>(BOOKMARKED_DEALS_BOX_NAME);
    await Hive.openBox<Deal>(PAST_SAVED_DEALS_BOX_NAME);
    await Hive.openBox<String>(RECENT_SEARCHES_BOX_NAME);
    await Hive.openBox<Deal>(LIBRARY_BOX_NAME);

    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final bool containsEncryptionKey = await secureStorage.containsKey(
      key: ITAD_SECURE_KEY,
    );

    if (!containsEncryptionKey) {
      await secureStorage.write(
        key: ITAD_SECURE_KEY,
        value: base64UrlEncode(Hive.generateSecureKey()),
      );
    }

    await Hive.openBox<ITADUser?>(
      ITAD_USER_BOX_NAME,
      encryptionCipher: HiveAesCipher(
        base64Url.decode((await secureStorage.read(key: ITAD_SECURE_KEY))!),
      ),
    );
  }

  Future<String> getCountry() async {
    return await settingsBox.get(
      PREF_COUNTRY,
      defaultValue: 'US',
    );
  }

  Future<void> setCountry(String countryCode) async {
    return settingsBox.put(
      PREF_COUNTRY,
      countryCode,
    );
  }

  Future<String> getCurrency() async {
    return await settingsBox.get(
      PREF_CURRENCY,
      defaultValue: 'USD',
    );
  }

  Future<void> setCurrency(String currency) async {
    return settingsBox.put(
      PREF_CURRENCY,
      currency,
    );
  }

  Future<bool> getShowHeaders() async {
    return await settingsBox.get(
      PREF_SHOW_HEADERS,
      defaultValue: true,
    );
  }

  Future<void> setShowHeaders(bool showHeaders) async {
    return settingsBox.put(
      PREF_SHOW_HEADERS,
      showHeaders,
    );
  }

  List<Deal> getWaitlistDeals() {
    return savedDealsBox.values.toList();
  }

  Future<void> saveDeal(Deal deal) async {
    return savedDealsBox.put(
      deal.id,
      Deal(
        id: deal.id,
        slug: deal.slug,
        title: deal.title,
        added: deal.added == 0
            ? DateTime.now().millisecondsSinceEpoch
            : deal.added,
        source: DealSource.itad,
      ),
    );
  }

  Future<void> removeDeal(Deal deal) async {
    return savedDealsBox.delete(deal.id);
  }

  Future<int> removeAllDeals() async {
    return savedDealsBox.clear();
  }

  Future<void> saveDeals(List<Deal> deals) async {
    return savedDealsBox.putAll(
      {
        for (final deal in deals)
          deal.id: Deal(
            id: deal.id,
            slug: deal.slug,
            title: deal.title,
            added: deal.added,
            source: deal.source,
          ),
      },
    );
  }

  Future<void> removeDeals(List<Deal> deals) async {
    return savedDealsBox.deleteAll(
      deals.map((e) => e.id).toList(),
    );
  }

  Future<void> removeDealsBySource(DealSource source) async {
    final List<Deal> deals = savedDealsBox.values
        .where(
          (deal) => deal.source == source,
        )
        .toList();

    return savedDealsBox.deleteAll(
      deals.map((e) => e.id).toList(),
    );
  }

  Future<List<int>> getSelectedStores() async {
    return await settingsBox.get(
      PREF_SELECTED_STORES,
      defaultValue: <int>[],
    );
  }

  Future<void> setSelectedStores(List<int> ids) async {
    return settingsBox.put(
      PREF_SELECTED_STORES,
      ids,
    );
  }

  Future<int> getLaunchCounter() async {
    return await settingsBox.get(
      PREF_LAUNCH_COUNTER,
      defaultValue: 0,
    );
  }

  Future<void> incrementLaunchCounter() async {
    final int count = await getLaunchCounter() + 1;

    Logger().i('Launch count: $count');

    return settingsBox.put(
      PREF_LAUNCH_COUNTER,
      count,
    );
  }

  Future<bool> getWaitlistNotifications() async {
    final bool isEnabledOnSystem =
        await AwesomeNotifications().isNotificationAllowed();

    return await settingsBox.get(
          PREF_WAITLIST_NOTIFICATIONS,
          defaultValue: false,
        ) &&
        isEnabledOnSystem;
  }

  Future<void> setWaitlistNotifications(bool isEnabled) async {
    return settingsBox.put(
      PREF_WAITLIST_NOTIFICATIONS,
      isEnabled,
    );
  }

  ObservatoryTheme getTheme() {
    return settingsBox.get(
      PREF_THEME,
      defaultValue: ObservatoryTheme(
        mode: ThemeMode.system.name,
        scheme: FlexScheme.mandyRed.name,
        isTrueBlack: false,
      ),
    );
  }

  Future<void> setTheme(ObservatoryTheme theme) async {
    return settingsBox.put(
      PREF_THEME,
      theme,
    );
  }

  Future<WaitlistSorting> getWaitlistSorting() async {
    final String sorting = await settingsBox.get(
      PREF_WAITLIST_SORTING,
      defaultValue: defaultWaitlistSorting.name.toString(),
    );

    return WaitlistSorting.values.asNameMap()[sorting] ??
        defaultWaitlistSorting;
  }

  Future<void> setWaitlistSorting(WaitlistSorting sorting) async {
    return settingsBox.put(
      PREF_WAITLIST_SORTING,
      sorting.name.toString(),
    );
  }

  List<Deal> getWaitlistPast() {
    return pastSavedDealsBox.values.toList();
  }

  Future<void> setWaitlistPast(List<Deal> waitlist) async {
    if (waitlist.isEmpty) {
      return;
    }

    await pastSavedDealsBox.clear();

    return pastSavedDealsBox.putAll({
      for (final Deal deal in waitlist)
        deal.id: Deal(
          id: deal.id,
          slug: deal.slug,
          title: deal.title,
          prices: deal.prices,
          added: deal.added,
          source: deal.source,
        ),
    });
  }

  Future<WaitlistSortingDirection> getWaitlistSortingDirection() async {
    final String? sorting = await settingsBox.get(
      PREF_WAITLIST_SORTING_DIRECTION,
      defaultValue: defaultWaitlistSortingDirection.name.toString(),
    );

    return WaitlistSortingDirection.values.asNameMap()[sorting] ??
        defaultWaitlistSortingDirection;
  }

  Future<void> setWaitlistSortingDirection(
    WaitlistSortingDirection direction,
  ) async {
    return settingsBox.put(
      PREF_WAITLIST_SORTING_DIRECTION,
      direction.name.toString(),
    );
  }

  SteamUser? getSteamUser() {
    return settingsBox.get(PREF_STEAM_USER);
  }

  Future<void> setSteamUser(SteamUser? user) async {
    return settingsBox.put(
      PREF_STEAM_USER,
      user,
    );
  }

  ITADUser? getITADUser() {
    return itadUserBox.get(ITAD_USER_BOX_NAME);
  }

  Future<void> setITADUser(ITADUser? user) async {
    return itadUserBox.put(ITAD_USER_BOX_NAME, user);
  }

  Future<List<String>> getRecentSearches() async {
    return recentSearchesBox.values.toList();
  }

  Future<void> saveToRecents(String query) async {
    final List<String> recentSearches = recentSearchesBox.values.toList();

    if (recentSearches.length >= RECENTS_LIMIT) {
      recentSearchesBox.delete(recentSearches.last);
    }

    return recentSearchesBox.put(query, query);
  }

  Future<void> removeFromRecents(String query) async {
    return recentSearchesBox.delete(query);
  }

  Future<int> clearAllRecents() async {
    return recentSearchesBox.clear();
  }

  Future<IGDBAccessToken?> getIGDBAccessToken() async {
    return await settingsBox.get(PREF_IGDB_ACCESS_TOKEN);
  }

  Future<void> setIGDBAccessToken(IGDBAccessToken? accessToken) async {
    if (accessToken == null) {
      return;
    }

    return settingsBox.put(
      PREF_IGDB_ACCESS_TOKEN,
      accessToken,
    );
  }

  ITADFilters getITADFilters() {
    return settingsBox.get(
      PREF_ITAD_FILTERS,
      defaultValue: const ITADFilters(),
    );
  }

  Future<void> setITADFilters(ITADFilters? filters) async {
    if (filters == null) {
      return;
    }

    return settingsBox.put(
      PREF_ITAD_FILTERS,
      filters,
    );
  }

  Future<List<String>> getPurchasedProductIds() async {
    return await settingsBox.get(
      PREF_PURCHASED_PRODUCTS,
      defaultValue: <String>[],
    );
  }

  Future<void> setPurchasedProductIds(List<String>? ids) async {
    if (ids == null) {
      return;
    }

    return settingsBox.put(
      PREF_PURCHASED_PRODUCTS,
      {...ids}.toList(),
    );
  }

  Future<List<Deal>> getBookmarks() async {
    return bookmarkedDealsBox.values.toList();
  }

  Future<List<Deal>> setBookmarks(List<Deal> bookmarks) async {
    await bookmarkedDealsBox.clear();
    await bookmarkedDealsBox.addAll(bookmarks);

    return bookmarks;
  }

  Future<void> saveBookmark(Deal deal) async {
    return bookmarkedDealsBox.put(
      deal.id,
      Deal(
        id: deal.id,
        slug: deal.slug,
        title: deal.title,
        added: deal.added,
        source: deal.source,
      ),
    );
  }

  Future<void> removeBoomarks(List<Deal> deals) async {
    return bookmarkedDealsBox.deleteAll(
      deals.map((deal) => deal.id).toList(),
    );
  }

  Future<int> removeAllBookmarks() async {
    return bookmarkedDealsBox.clear();
  }

  Future<bool> getCollapsePinned() async {
    return await settingsBox.get(
      PREF_COLLAPSE_PINNED,
      defaultValue: false,
    );
  }

  Future<void> setCollapsePinned(bool collapse) async {
    return settingsBox.put(
      PREF_COLLAPSE_PINNED,
      collapse,
    );
  }

  Future<bool> getMuteGamesInLibrary() async {
    return await settingsBox.get(
      PREF_MUTE_GAMES_IN_LIBRARY,
      defaultValue: true,
    );
  }

  Future<void> setMuteGamesInLibrary(bool mute) async {
    return settingsBox.put(
      PREF_MUTE_GAMES_IN_LIBRARY,
      mute,
    );
  }

  Future<List<Deal>> getLibrary() async {
    return libraryBox.values.toList();
  }

  Future<List<Deal>> setLibrary(List<Deal> games) async {
    final List<Deal> library = await getLibrary();
    final List<Deal> newList = Set<Deal>.of({...library, ...games}).toList();

    await libraryBox.clear();
    await libraryBox.putAll({
      for (final Deal deal in newList)
        deal.id: Deal(
          id: deal.id,
          slug: deal.slug,
          title: deal.title,
          added: deal.added,
          source: deal.source,
        ),
    });

    return newList;
  }
}
