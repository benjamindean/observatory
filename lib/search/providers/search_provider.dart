import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:observatory/search/providers/recents_provider.dart';
import 'package:observatory/search/providers/search_results_provider.dart';
import 'package:observatory/search/state/search_state.dart';
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
      isOpen: false,
      focusNode: FocusNode(),
      searchInputController: TextEditingController(),
    );
  }

  void reset() {
    ref.read(searchResultsProvider.notifier).clear();

    state.searchInputController.clear();
    state = state.copyWith(
      query: null,
      isOpen: false,
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
    if (query.isEmpty) {
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

    final List<Deal> results = await GetIt.I<API>().search(
      query: query,
    );
    final List<Deal> deals = Set<Deal>.of(results).toList();

    ref.read(searchResultsProvider.notifier).setResults(deals);
    ref.read(asynRecentsProvider.notifier).addRecent(query);

    state = state.copyWith(
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

final dealSearchProvider = searchProvider(
  SearchType.search,
);

final waitlistSearchProvider = searchProvider(
  SearchType.filter,
);
