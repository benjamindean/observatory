import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:observatory/search/search_state.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/api/api.dart';
import 'package:observatory/shared/models/deal.dart';

enum SearchType {
  search,
  filter,
}

class SearchNotifier extends FamilyNotifier<SearchState, SearchType> {
  @override
  SearchState build(SearchType arg) => SearchState(
        query: null,
        deals: null,
        focusNode: FocusNode(),
        isOpen: false,
        isFocused: false,
        searchInputController: TextEditingController(),
      );

  void reset() {
    state.searchInputController.clear();
    state.focusNode.unfocus();

    state = state.copyWith(
      query: null,
      deals: null,
      isOpen: false,
      isFocused: false,
    );
  }

  void setQuery(String query) {
    state = state.copyWith(query: query);
  }

  void setIsOpen(bool isOpen) {
    state = state.copyWith(isOpen: isOpen);
  }

  void setIsFocused(bool isFocused) {
    if (isFocused) {
      state.focusNode.requestFocus();
    } else {
      state.focusNode.unfocus();
    }

    state = state.copyWith(
      isFocused: isFocused,
    );
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

    final API api = GetIt.I<API>();
    final List<Deal> results = await api.getSearchResults(query: query);
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
    setIsFocused(true);
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
