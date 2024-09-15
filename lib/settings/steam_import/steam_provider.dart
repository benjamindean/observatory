import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/settings/steam_import/steam_state.dart';
import 'package:observatory/shared/api/api.dart';
import 'package:observatory/shared/helpers/steam_openid.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/waitlist/providers/waitlist_provider.dart';

class SteamNotifier extends AutoDisposeNotifier<SteamState> {
  @override
  SteamState build() {
    return SteamState(
      steamUser: GetIt.I<SettingsRepository>().getSteamUser(),
    );
  }

  Future<void> unlinkSteamAccount() async {
    await GetIt.I<SettingsRepository>().setSteamUser(null);

    state = state.copyWith(
      steamUser: null,
      isLoading: false,
      error: null,
    );
  }

  Future<SteamUser> logIn(
    Uri uri,
  ) async {
    state = state.copyWith(
      isLoading: true,
    );

    OpenId openId = const OpenId();

    final String steamId = await openId.validate(
      uri.queryParameters,
    );

    final SteamUser steamUser = await GetIt.I<API>().fetchSteamUser(steamId);

    await GetIt.I<SettingsRepository>().setSteamUser(steamUser);

    state = state.copyWith(
      steamUser: steamUser,
      isLoading: false,
    );

    return steamUser;
  }

  Future<List<Deal>?> import() async {
    final SteamUser? steamUser = GetIt.I<SettingsRepository>().getSteamUser();

    if (steamUser == null) {
      return null;
    }

    state = state.copyWith(
      isLoading: true,
      steamUser: steamUser,
    );

    try {
      final List<Deal> wishlist = await GetIt.I<API>().fetchSteamWishlist(
        steamUser.steamid!,
      );
      final List<Deal> deals = await GetIt.I<API>().gameIdsBySteamIds(
        wishlist,
      );
      final List<String> dealIds = deals.map((deal) => deal.id).toList();

      if (deals.isNotEmpty) {
        final List<Deal> steamDeals =
            (ref.read(asyncWaitListProvider).valueOrNull ?? [])
                .where((game) => game.source == DealSource.steam)
                .toList();

        final List<Deal> removedDeals = steamDeals.where(
          (deal) {
            return !dealIds.contains(deal.id);
          },
        ).toList();

        await GetIt.I<SettingsRepository>().removeDeals(removedDeals);
        await GetIt.I<SettingsRepository>().saveDeals(deals.toList());
      }

      await ref.watch(asyncWaitListProvider.notifier).reset();

      state = state.copyWith(
        isLoading: false,
        deals: deals.reversed.toList(),
        error: null,
      );

      return deals;
    } catch (error, stackTrace) {
      Logger().e(
        'Failed to import Steam wishlist',
        error: error,
        stackTrace: stackTrace,
      );

      FirebaseCrashlytics.instance.recordError(
        error,
        stackTrace,
      );

      state = state.copyWith(
        isLoading: false,
        error:
            'User not found or your wishlist is empty. Please make sure that your profile is public.',
      );

      return null;
    }
  }
}

final steamProvider = NotifierProvider.autoDispose<SteamNotifier, SteamState>(
  SteamNotifier.new,
);
