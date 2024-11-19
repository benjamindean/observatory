import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/models/deal.dart';

class AsyncLibraryNotifier extends AsyncNotifier<List<Deal>> {
  @override
  Future<List<Deal>> build() async {
    return await fetchLibrary();
  }

  Future<void> setLibrary(List<Deal> games) async {
    state = await AsyncValue.guard(
      () async {
        await GetIt.I<SettingsRepository>().setLibrary(games);

        return games;
      },
    );
  }

  Future<List<Deal>> fetchLibrary() async {
    return GetIt.I<SettingsRepository>().getLibrary();
  }
}

final asyncLibraryProvider =
    AsyncNotifierProvider<AsyncLibraryNotifier, List<Deal>>(() {
  return AsyncLibraryNotifier();
});

class LibraryIdsNotifier extends Notifier<List<String>> {
  @override
  List<String> build() {
    final List<Deal> games = ref.watch(asyncLibraryProvider).valueOrNull ?? [];

    return games.map((game) => game.id).toList();
  }
}

final libraryIdsProvider = NotifierProvider<LibraryIdsNotifier, List<String>>(
  LibraryIdsNotifier.new,
);
