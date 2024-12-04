import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:observatory/library/providers/library_provider.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/auth/state/steam_state.dart';
import 'package:observatory/shared/api/api.dart';
import 'package:observatory/auth/providers/steam_openid.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/waitlist/providers/waitlist_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class SteamNotifier extends AutoDisposeNotifier<SteamState> {
  @override
  SteamState build() {
    return SteamState(
      user: GetIt.I<SettingsRepository>().getSteamUser(),
    );
  }

  Future<void> unlinkSteamAccount() async {
    await GetIt.I<SettingsRepository>().setSteamUser(null);

    state = state.copyWith(
      user: null,
      isLoading: false,
      error: null,
    );
  }

  Future<SteamUser> handleRedirect(Uri uri) async {
    state = state.copyWith(
      isLoading: true,
    );

    OpenId openId = const OpenId();

    final String steamId = await openId.validate(uri.queryParameters);
    final SteamUser steamUser = await GetIt.I<API>().fetchSteamUser(steamId);

    await GetIt.I<SettingsRepository>().setSteamUser(steamUser);

    state = state.copyWith(
      user: steamUser,
      isLoading: false,
    );

    return steamUser;
  }

  Future<List<Deal>?> importWishlist() async {
    final SteamUser? steamUser = GetIt.I<SettingsRepository>().getSteamUser();

    if (steamUser == null) {
      return null;
    }

    state = state.copyWith(
      user: steamUser,
    );

    final List<Deal> wishlist = await GetIt.I<API>().fetchSteamWishlist(
      steamUser.steamid!,
    );

    if (wishlist.isEmpty) {
      state = state.copyWith(
        error:
            'User not found or your wishlist is empty. Please make sure that your profile and library are public.',
      );

      return [];
    }

    await ref
        .watch(asyncWaitListProvider.notifier)
        .removeFromWaitListBySource(DealSource.steam);

    await ref.watch(asyncWaitListProvider.notifier).addToWaitlist(wishlist);
    await ref.watch(asyncWaitListProvider.notifier).reset();

    state = state.copyWith(
      deals: wishlist.reversed.toList(),
      error: null,
    );

    return wishlist;
  }

  Future<List<Deal>?> importLibrary() async {
    final SteamUser? steamUser = GetIt.I<SettingsRepository>().getSteamUser();

    if (steamUser == null) {
      return null;
    }

    state = state.copyWith(
      user: steamUser,
    );

    final List<Deal> library = await GetIt.I<API>().fetchSteamLibrary(
      steamUser.steamid!,
    );

    if (library.isEmpty) {
      return [];
    }

    await ref.watch(asyncLibraryProvider.notifier).setLibrary(library);

    state = state.copyWith(
      error: null,
    );

    return library;
  }

  Future<void> importData() async {
    state = state.copyWith(
      isLoading: true,
    );

    try {
      await importWishlist();
    } catch (error, stackTrace) {
      Logger().e(
        'Failed to import Steam wishlist',
        error: error,
        stackTrace: stackTrace,
      );

      Sentry.captureException(
        error,
        stackTrace: stackTrace,
      );
    }

    try {
      await importLibrary();
    } catch (error, stackTrace) {
      Logger().e(
        'Failed to import Steam library',
        error: error,
        stackTrace: stackTrace,
      );

      Sentry.captureException(
        error,
        stackTrace: stackTrace,
      );
    }

    state = state.copyWith(
      isLoading: false,
    );
  }
}

final steamProvider = NotifierProvider.autoDispose<SteamNotifier, SteamState>(
  SteamNotifier.new,
);
