import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:observatory/settings/settings_repository.dart';

class AsyncRecentsNotifier extends AsyncNotifier<List<String>> {
  @override
  Future<List<String>> build() async {
    return _initSearch();
  }

  Future<List<String>> _initSearch() async {
    return (await GetIt.I<SettingsRepository>().getRecentSearches())
        .reversed
        .toList();
  }

  Future<void> addRecent(String query) async {
    state = await AsyncValue.guard(
      () async {
        await GetIt.I<SettingsRepository>().saveToRecents(query.trim());

        return Set<String>.of(
          List.of(state.value ?? [])..insert(0, query.trim()),
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
