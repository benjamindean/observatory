import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/settings/steam_import/steam_import_state.dart';
import 'package:observatory/shared/api/api.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/waitlist/waitlist_provider.dart';

class SteamImportNotifier extends AutoDisposeNotifier<SteamImportState> {
  @override
  SteamImportState build() {
    return SteamImportState(
      focusNode: FocusNode(),
      usernameInputController: TextEditingController(
        text: GetIt.I<SettingsRepository>().getSteamUsername(),
      ),
    );
  }

  Future<List<Deal>?> fetch() async {
    final String username = state.usernameInputController.value.text.trim();

    state = state.copyWith(
      isLoading: true,
      username: username,
    );

    try {
      final List<Deal> response = await GetIt.I<API>().fetchSteamWishlist(
        username,
      );

      state = state.copyWith(
        isLoading: false,
        deals: response.reversed.toList(),
        selectedDeals: response.reversed.toList(),
        error: null,
      );

      return response;
    } catch (error, stackTrace) {
      Logger().e(
        'Failed to fetch Steam wishlist',
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

  Future<List<Deal>?> import() async {
    state = state.copyWith(isImporting: true);

    try {
      final List<Deal> deals = await GetIt.I<API>().gameIdsBySteamIds(
        state.selectedDeals,
      );

      if (deals.isNotEmpty) {
        await GetIt.I<SettingsRepository>().removeDealsFromSteam();
        await GetIt.I<SettingsRepository>().saveDeals(deals.toList());
      }

      if (state.username != null) {
        await GetIt.I<SettingsRepository>().setSteamUsername(state.username!);
      }

      await ref.watch(asyncWaitListProvider.notifier).reset();

      state = build();

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
        isImporting: false,
        error: 'Failed to import your wishlist. Please try again later.',
        deals: null,
      );
    }

    return [];
  }

  Future<List<Deal>?> reImport() async {
    await fetch();

    return import();
  }

  void add(Deal deal) {
    state = state.copyWith(selectedDeals: [...state.selectedDeals, deal]);
  }

  void remove(Deal deal) {
    state = state.copyWith(
      selectedDeals: [...state.selectedDeals]
          .where(
            (existingDeal) => existingDeal.steamId != deal.steamId,
          )
          .toList(),
    );
  }

  void toggle(Deal deal, bool isEnabled) {
    if (isEnabled) {
      return add(deal);
    }

    return remove(deal);
  }

  void set(List<Deal> deals) {
    state = state.copyWith(selectedDeals: deals);
  }

  void reset() {
    state.focusNode.unfocus();
    state.usernameInputController.clear();

    state = build();
  }
}

final steamImportProvider =
    NotifierProvider.autoDispose<SteamImportNotifier, SteamImportState>(
  SteamImportNotifier.new,
);
