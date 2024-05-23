import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:observatory/search/search_provider.dart';
import 'package:observatory/search/search_state.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/models/price.dart';
import 'package:observatory/shared/models/shop.dart';

final List<Deal> results = [
  const Deal(
    id: '018d937f-636c-72e7-ac79-de13a54877c8',
    slug: 'slay-the-princess',
    type: 'game',
    title: 'Slay the Princess',
    steamId: null,
    prices: [
      Price(
        price: PriceDetails(
          amount: 14.39,
          amountInt: 1439,
          currency: 'USD',
        ),
        regular: PriceDetails(
          amount: 17.99,
          amountInt: 1799,
          currency: 'USD',
        ),
        cut: 20.0,
        shop: Shop(
          id: 61,
          name: 'Steam',
        ),
        drm: [],
        url: 'https://itad.link/018d9386-cb20-727a-9d0d-2ea25e9fde79/',
        voucher: null,
        timestamp: '2024-03-25T18:18:30+01:00',
      ),
    ],
    info: null,
    overview: null,
    isLoading: false,
    added: 0,
    source: DealSource.itad,
  ),
];

class SearchNotifierMock extends FamilyNotifier<SearchState, SearchType>
    with Mock
    implements SearchNotifier {
  @override
  SearchState build(SearchType arg) => SearchState(
        query: 'Slay the Princess',
        deals: results,
        focusNode: FocusNode(),
        isOpen: true,
        searchInputController: TextEditingController(
          text: 'Slay the Princess',
        ),
      );

  @override
  void reset() {
    state = state;
  }

  @override
  void setQuery(String query) {
    state = state;
  }

  @override
  void setIsOpen() {
    state = state;
  }

  @override
  Future<void> performSearch(String query) async {
    state = state;
  }

  @override
  void clear() {
    state = state;
  }
}

final searchProviderMock =
    NotifierProviderFamily<SearchNotifierMock, SearchState, SearchType>(
  SearchNotifierMock.new,
);

final searchResultsProviderMock = searchProviderMock(
  SearchType.search,
);
