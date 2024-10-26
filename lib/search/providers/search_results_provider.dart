import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/shared/models/deal.dart';

class SearchResultsNotifier extends Notifier<List<Deal>?> {
  @override
  List<Deal>? build() {
    return null;
  }

  void setResults(List<Deal> results) {
    state = results;
  }

  void clear() {
    state = null;
  }
}

final searchResultsProvider =
    NotifierProvider<SearchResultsNotifier, List<Deal>?>(
  SearchResultsNotifier.new,
);
