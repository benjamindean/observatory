import 'dart:async';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/models/observatory_theme.dart';

const SETTINGS_BOX_NAME = 'observatory_user_data';
const SAVED_DEALS_BOX_NAME = 'observatory_saved_deals';
const RECENT_SEARCHES_BOX_NAME = 'observatory_recent_searches';

const int IMAGE_WIDTH = 600;
const int IMAGE_HEIGHT = 344;

enum WaitlistSorting { date_added, price_cut, price, title }

enum WaitlistSortingDirection { asc, desc }

enum DealCardType { expanded, compact }

enum DealCategory {
  all,
  steam_top_sellers,
  steam_featured,
}

final Map<DealCategory, Map<String, String>> dealCategoryLabels = {
  DealCategory.all: {
    'title': 'All Deals',
    'subtitle': 'All available deals.',
  },
  DealCategory.steam_top_sellers: {
    'title': 'Steam Store',
    'subtitle':
        'A combination of Steam\'s Specials, Top Sellers and New Releases.',
  },
  DealCategory.steam_featured: {
    'title': 'Steam Featured',
    'subtitle': 'Featured games from the Steam\'s main page.',
  },
};

class SettingsRepository {
  final Box settingsBox = Hive.box(SETTINGS_BOX_NAME);
  final Box<Deal> savedDealsBox = Hive.box<Deal>(
    SAVED_DEALS_BOX_NAME,
  );
  final Box<String> recentSearchesBox = Hive.box<String>(
    RECENT_SEARCHES_BOX_NAME,
  );

  final int RECENTS_LIMIT = 10;

  final String PREF_DEFAULT_COUNTRY = 'observatory_default_country';
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
  final String PREF_WAITLIST_PAST = 'observatory_waitlist_past';
  final String PREF_STEAM_USERNAME = 'observatory_steam_username';

  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(DealSourceAdapter());
    Hive.registerAdapter(DealAdapter());
    Hive.registerAdapter(ObservatoryThemeAdapter());

    await Hive.openBox(SETTINGS_BOX_NAME);
    await Hive.openBox<Deal>(SAVED_DEALS_BOX_NAME);
    await Hive.openBox<String>(RECENT_SEARCHES_BOX_NAME);
  }

  String getCountry() {
    return settingsBox.get(
      PREF_DEFAULT_COUNTRY,
      defaultValue: 'US',
    );
  }

  Future<void> setCountry(String countryCode) async {
    return settingsBox.put(
      PREF_DEFAULT_COUNTRY,
      countryCode,
    );
  }

  bool getShowHeaders() {
    return settingsBox.get(
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
        added: DateTime.now().millisecondsSinceEpoch,
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

  Future<void> removeDealsFromSteam() async {
    final List<Deal> steamDeals = savedDealsBox.values
        .where((d) => d.source == DealSource.steam)
        .toList();

    return removeDeals(steamDeals);
  }

  List<int> getSelectedStores() {
    return settingsBox.get(
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

  DealCategory getDealsTab() {
    final String category = settingsBox.get(
      PREF_DEALS_TAB,
      defaultValue: DealCategory.all.name.toString(),
    );

    return DealCategory.values.asNameMap()[category]!;
  }

  Future<void> setDealsTab(DealCategory category) async {
    return settingsBox.put(
      PREF_DEALS_TAB,
      category.name.toString(),
    );
  }

  bool getWaitlistNotifications() {
    return settingsBox.get(
      PREF_WAITLIST_NOTIFICATIONS,
      defaultValue: false,
    );
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

  DealCardType getDealCardType() {
    final String type = settingsBox.get(
      PREF_DEAL_CARD_TYPE,
      defaultValue: DealCardType.compact.name.toString(),
    );

    return DealCardType.values.asNameMap()[type]!;
  }

  Future<void> setDealCardType(DealCardType type) async {
    return settingsBox.put(
      PREF_DEAL_CARD_TYPE,
      type.name.toString(),
    );
  }

  WaitlistSorting getWaitlistSorting() {
    final String sorting = settingsBox.get(
      PREF_WAITLIST_SORTING,
      defaultValue: WaitlistSorting.date_added.name.toString(),
    );

    return WaitlistSorting.values.asNameMap()[sorting]!;
  }

  Future<void> setWaitlistSorting(WaitlistSorting sorting) async {
    return settingsBox.put(
      PREF_WAITLIST_SORTING,
      sorting.name.toString(),
    );
  }

  List<Deal> getWaitlistPast() {
    return settingsBox.get(
      PREF_WAITLIST_PAST,
      defaultValue: [],
    );
  }

  Future<void> setWaitlistPast(List<Deal> waitlist) async {
    if (waitlist.isEmpty) {
      return;
    }

    return settingsBox.put(
      PREF_WAITLIST_PAST,
      waitlist
          .map(
            (e) => Deal(
              id: e.id,
              slug: e.slug,
              title: e.title,
              prices: e.prices,
            ),
          )
          .toList(),
    );
  }

  WaitlistSortingDirection getWaitlistSortingDirection() {
    final String? sorting = settingsBox.get(
      PREF_WAITLIST_SORTING_DIRECTION,
      defaultValue: WaitlistSortingDirection.asc.name.toString(),
    );

    return WaitlistSortingDirection.values.asNameMap()[sorting]!;
  }

  Future<void> setWaitlistSortingDirection(
    WaitlistSortingDirection direction,
  ) async {
    return settingsBox.put(
      PREF_WAITLIST_SORTING_DIRECTION,
      direction.name.toString(),
    );
  }

  String? getSteamUsername() {
    return settingsBox.get(PREF_STEAM_USERNAME);
  }

  Future<void> setSteamUsername(String username) async {
    return settingsBox.put(
      PREF_STEAM_USERNAME,
      username,
    );
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
}
