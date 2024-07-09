import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/models/deal.dart';

class AsyncBookmarksNotifier extends AsyncNotifier<List<Deal>> {
  Future<List<Deal>> _fetchBookmarks() async {
    return GetIt.I<SettingsRepository>().getBookmarks();
  }

  @override
  Future<List<Deal>> build() async {
    return _fetchBookmarks();
  }

  Future<void> addBookmark(Deal deal) async {
    state = await AsyncValue.guard(
      () async {
        await GetIt.I<SettingsRepository>().saveBookmark(deal);

        return Set<Deal>.of(
          List.of(
            state.requireValue
              ..add(
                deal.copyWith(
                  added: DateTime.now().millisecondsSinceEpoch,
                ),
              ),
          ),
        ).toList();
      },
    );
  }

  Future<void> removeBookmark(Deal deal) async {
    state = await AsyncValue.guard(
      () async {
        await GetIt.I<SettingsRepository>().removeBoomark(deal);

        return List.of(state.requireValue)
          ..removeWhere(
            (element) => element.id == deal.id,
          );
      },
    );
  }

  Future<void> clearBookmarks() async {
    state = await AsyncValue.guard(
      () async {
        await GetIt.I<SettingsRepository>().removeAllBookmarks();

        return build();
      },
    );
  }
}

final asyncBookmarksProvider =
    AsyncNotifierProvider<AsyncBookmarksNotifier, List<Deal>>(() {
  return AsyncBookmarksNotifier();
});

class BookmarkIdsNotifier extends Notifier<List<String>> {
  @override
  List<String> build() {
    final List<Deal> bookmarks =
        ref.watch(asyncBookmarksProvider).valueOrNull ?? [];

    return bookmarks.map((deal) => deal.id).toList();
  }
}

final bookmarkIdsProvider = NotifierProvider<BookmarkIdsNotifier, List<String>>(
  BookmarkIdsNotifier.new,
);
