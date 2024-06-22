import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:observatory/search/state/search_state.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/api/api.dart';
import 'package:observatory/shared/models/deal.dart';

enum SearchType {
  search,
  filter,
}

class SearchNotifier extends FamilyNotifier<SearchState, SearchType> {
  @override
  SearchState build(SearchType arg) {
    return SearchState(
      query: null,
      deals: null,
      isOpen: false,
      focusNode: FocusNode(),
      searchInputController: TextEditingController(),
    );
  }

  void reset() {
    state.searchInputController.dispose();
    state.focusNode.dispose();

    state = state.copyWith(
      query: null,
      deals: null,
      isOpen: false,
      focusNode: FocusNode(),
      searchInputController: TextEditingController(),
    );
  }

  void setQuery(String query) {
    state = state.copyWith(query: query);
  }

  void setIsOpen() {
    state = state.copyWith(
      isOpen: true,
    );

    state.focusNode.requestFocus();
  }

  Future<void> performSearch(String query) async {
    if (query.trim().isEmpty) {
      return;
    }

    state.searchInputController.value = TextEditingValue(
      text: query,
    );

    state = state.copyWith(
      isOpen: true,
      isLoading: true,
      query: query,
    );

    final List<Deal> results = await GetIt.I<API>().getSearchResults(
      query: query,
    );
    final List<Deal> deals = Set<Deal>.from(results).toList();

    FirebaseAnalytics.instance.logEvent(
      name: 'search_performed',
    );

    state = state.copyWith(
      deals: deals,
      query: query,
      isLoading: false,
      isOpen: true,
    );
  }

  void clear() {
    state.searchInputController.clear();
    state.focusNode.requestFocus();

    state = state.copyWith(
      query: null,
    );
  }
}

final searchProvider =
    NotifierProviderFamily<SearchNotifier, SearchState, SearchType>(
  SearchNotifier.new,
);

final searchResultsProvider = searchProvider(
  SearchType.search,
);

final filterResultsProvider = searchProvider(
  SearchType.filter,
);

class AsyncRecentsNotifier extends AsyncNotifier<List<String>> {
  @override
  Future<List<String>> build() async {
    return _initSearch();
  }

  Future<List<String>> _initSearch() async {
    return GetIt.I<SettingsRepository>().getRecentSearches();
  }

  Future<void> addRecent(String query) async {
    state = await AsyncValue.guard(
      () async {
        await GetIt.I<SettingsRepository>().saveToRecents(query.trim());

        return Set<String>.from(
          List.from(state.value ?? [])..add(query.trim()),
        ).toList();
      },
    );
  }

  Future<void> removeRecent(String query) async {
    state = await AsyncValue.guard(
      () async {
        await GetIt.I<SettingsRepository>().removeFromRecents(query.trim());

        return [...state.requireValue]..remove(query.trim());
      },
    );
  }

  Future<void> clearRecents() async {
    state = await AsyncValue.guard(
      () async {
        await GetIt.I<SettingsRepository>().clearAllRecents();

        return [];
      },
    );
  }
}

final asynRecentsProvider =
    AsyncNotifierProvider<AsyncRecentsNotifier, List<String>>(() {
  return AsyncRecentsNotifier();
});
