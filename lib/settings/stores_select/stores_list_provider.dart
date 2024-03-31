import 'package:flutter_riverpod/flutter_riverpod.dart';

class StoreList extends AutoDisposeFamilyNotifier<List<int>, List<int>> {
  @override
  build(List<int> arg) => arg;

  void set(List<int> ids) {
    state = ids;
  }

  void toggle(int id, bool isEnabled) {
    if (isEnabled) {
      return add(id);
    }

    return remove(id);
  }

  void add(int id) {
    state = [...state, id];
  }

  void remove(int id) {
    state = [...state].where((storeId) => id != storeId).toList();
  }

  void all(int id) {
    state = [...state, id];
  }
}

final storeListProvider = NotifierProvider.family
    .autoDispose<StoreList, List<int>, List<int>>(StoreList.new);
