import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/settings/steam_import/steam_import_state.dart';
import 'package:observatory/shared/api/api.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/waitlist/providers/waitlist_provider.dart';

class SteamImportNotifier extends AutoDisposeNotifier<SteamImportState> {
  @override
  SteamImportState build() {
    return SteamImportState(
      steamUser: GetIt.I<SettingsRepository>().getSteamUser(),
    );
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

      if (deals.isNotEmpty) {
        final List<Deal> steamDeals =
            (ref.read(asyncWaitListProvider).valueOrNull ?? [])
                .where((game) => game.source == DealSource.steam)
                .toList();

        await GetIt.I<SettingsRepository>().removeDeals(steamDeals);
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

final steamImportProvider =
    NotifierProvider.autoDispose<SteamImportNotifier, SteamImportState>(
  SteamImportNotifier.new,
);
