import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/waitlist/providers/waitlist_provider.dart';

class AsyncBookmarksNotifier extends AsyncNotifier<List<Deal>> {
  @override
  Future<List<Deal>> build() async {
    final List<String> wailtistIds = ref.watch(waitlistIdsProvider);

    if (wailtistIds.isEmpty) {
      return [];
    }

    return filterBookmarks(wailtistIds);
  }

  Future<void> cleanUp() async {
    final List<String> wailtistIds = ref.read(waitlistIdsProvider);

    if (wailtistIds.isEmpty) {
      return;
    }

    final List<Deal> bookmarks = await fetchBookmarks();
    final List<Deal> filteredBookmarks = await filterBookmarks(wailtistIds);

    if (filteredBookmarks.length != bookmarks.length) {
      await GetIt.I<SettingsRepository>().setBookmarks(filteredBookmarks);
    }

    ref.invalidateSelf();
  }

  Future<List<Deal>> filterBookmarks(List<String> wailtistIds) async {
    if (wailtistIds.isEmpty) {
      return [];
    }

    final List<Deal> bookmarks = await fetchBookmarks();

    return bookmarks.where((deal) => wailtistIds.contains(deal.id)).toList();
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

  Future<void> removeBookmarks(List<Deal> deals) async {
    state = await AsyncValue.guard(
      () async {
        final List<String> dealIds = deals.map((deal) => deal.id).toList();

        await GetIt.I<SettingsRepository>().removeBoomarks(deals);

        return List.of(state.requireValue)
          ..removeWhere(
            (element) => dealIds.contains(element.id),
          );
      },
    );
  }

  Future<void> clearBookmarks() async {
    state = await AsyncValue.guard(
      () async {
        await GetIt.I<SettingsRepository>().removeAllBookmarks();

        return [];
      },
    );
  }

  Future<List<Deal>> fetchBookmarks() async {
    return GetIt.I<SettingsRepository>().getBookmarks();
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
