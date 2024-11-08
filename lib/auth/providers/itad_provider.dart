import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:observatory/auth/state/itad_state.dart';
import 'package:oauth2/oauth2.dart';
import 'package:observatory/library/providers/library_provider.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/constans.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/waitlist/providers/waitlist_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

final Uri authroizationUrl = Uri.parse(
  'https://isthereanydeal.com/oauth/authorize/',
);
final Uri tokenUrl = Uri.parse(
  'https://isthereanydeal.com/oauth/token/',
);
final Uri redirectUrl = Uri.parse(
  'https://getobservatory.app/app/auth/itad',
);

const List<String> authScopes = [
  'user_info',
  'notes_read',
  'notes_write',
  'profiles',
  'wait_read',
  'wait_write',
  'coll_read',
  'coll_write',
];

class ITADNotifier extends Notifier<ITADState> {
  @override
  ITADState build() {
    final ITADUser? user = GetIt.I<SettingsRepository>().getITADUser();

    if (user != null && user.credentials != null) {
      return ITADState(
        user: user,
        client: Client(
          Credentials.fromJson(
            user.credentials!,
          ),
          identifier: API_IDENTIFIER,
          secret: API_SECRET,
        ),
        isLoading: false,
      );
    }

    return const ITADState();
  }

  AuthorizationCodeGrant getGrant() {
    if (state.grant != null) {
      return state.grant!;
    }

    final AuthorizationCodeGrant grant = AuthorizationCodeGrant(
      API_IDENTIFIER,
      authroizationUrl,
      tokenUrl,
      secret: API_SECRET,
    );

    state = state.copyWith(
      grant: grant,
    );

    return grant;
  }

  Future<void> reset() async {
    await GetIt.I<SettingsRepository>().setITADUser(null);

    state.grant?.close();
    state.client?.close();

    state = const ITADState();

    ref.invalidateSelf();
  }

  Uri getAuthURL() {
    state = state.copyWith(
      isLoading: true,
    );

    if (state.autorizationUrl != null) {
      return state.autorizationUrl!;
    }

    final AuthorizationCodeGrant grant = getGrant();
    final Uri authUrl = grant.getAuthorizationUrl(
      redirectUrl,
      scopes: authScopes,
    );

    state = state.copyWith(
      autorizationUrl: authUrl,
    );

    return authUrl;
  }

  Future<void> handleRedirect(Uri uri) async {
    state = state.copyWith(
      isLoading: true,
    );

    final AuthorizationCodeGrant grant = getGrant();

    try {
      final Client client = await grant.handleAuthorizationResponse(
        uri.queryParameters,
      );

      final userResponse = await client.get(
        Uri.parse('https://api.isthereanydeal.com/user/info/v2'),
      );

      final ITADUser user = ITADUser(
        username: json.decode(userResponse.body)['username'],
        credentials: client.credentials.toJson(),
      );

      await GetIt.I<SettingsRepository>().setITADUser(user);

      state = ITADState(
        user: user,
        client: client,
        isLoading: false,
      );
    } catch (error, stackTrace) {
      Logger().e(
        'Failed to authenticate with ITAD',
        error: error,
        stackTrace: stackTrace,
      );

      return reset();
    }
  }

  Future<void> unlinkAccount() async {
    return reset();
  }

  Future<void> addToWaitlist(List<String> dealIds) async {
    if (state.client == null) {
      return;
    }

    await state.client?.put(
      Uri.parse('https://api.isthereanydeal.com/waitlist/games/v1'),
      body: json.encode(dealIds),
    );
  }

  Future<void> removeFromWaitlist(List<String> dealIds) async {
    if (state.client == null) {
      return;
    }

    await state.client?.delete(
      Uri.parse('https://api.isthereanydeal.com/waitlist/games/v1'),
      body: json.encode(dealIds),
    );
  }

  Future<List<Deal>> getWaitlist() async {
    if (state.client == null) {
      return [];
    }

    final itadWaitlistResponse = await state.client?.get(
      Uri.parse('https://api.isthereanydeal.com/waitlist/games/v1'),
    );

    if (itadWaitlistResponse == null) {
      return [];
    }

    return json
        .decode(itadWaitlistResponse.body)
        .map<Deal>(
          (deal) => Deal(
            id: deal['id'],
            title: deal['title'],
            source: DealSource.itad,
            type: deal['type'] ?? 'game',
            added: deal['added'] != null
                ? DateTime.parse(deal['added']).millisecondsSinceEpoch
                : 0,
          ),
        )
        .toList();
  }

  Future<List<Deal>> getCollection() async {
    if (state.client == null) {
      return [];
    }

    final itadCollectionResponse = await state.client?.get(
      Uri.parse('https://api.isthereanydeal.com/collection/games/v1'),
    );

    if (itadCollectionResponse == null) {
      return [];
    }

    return json
        .decode(itadCollectionResponse.body)
        .map<Deal>(
          (deal) => Deal(
            id: deal['id'],
            title: deal['title'],
            source: DealSource.itad,
            type: deal['type'] ?? 'game',
            added: deal['added'] != null
                ? DateTime.parse(deal['added']).millisecondsSinceEpoch
                : 0,
          ),
        )
        .toList();
  }

  Future<void> clearWaitlist() async {
    if (state.client == null) {
      return;
    }

    final itadWaitlistResponse = await state.client?.get(
      Uri.parse('https://api.isthereanydeal.com/waitlist/games/v1'),
    );

    if (itadWaitlistResponse == null) {
      return;
    }

    final List<String> waitlistIds = ref.read(waitlistIdsProvider);

    await state.client?.delete(
      Uri.parse('https://api.isthereanydeal.com/waitlist/games/v1'),
      body: json.encode(waitlistIds),
    );
  }

  Future<List<Deal>?> importWaitlist() async {
    if (state.client == null) {
      return null;
    }

    final List<Deal> deals = await getWaitlist();

    if (deals.isNotEmpty) {
      await ref
          .watch(asyncWaitListProvider.notifier)
          .removeFromWaitListBySource(
            DealSource.itad,
          );
      await ref.read(asyncWaitListProvider.notifier).addToWaitlist(deals);
      await ref.read(asyncWaitListProvider.notifier).reset();

      final List<String> syncBackDeals = ref
              .watch(asyncWaitListProvider)
              .value
              ?.where(
                (deal) => [DealSource.itad, DealSource.steam].contains(
                  deal.source,
                ),
              )
              .map(
                (deal) => deal.id,
              )
              .toList() ??
          [];

      if (syncBackDeals.isNotEmpty) {
        await addToWaitlist(syncBackDeals);
      }
    }

    state = state.copyWith(
      error: null,
    );

    return deals;
  }

  Future<List<Deal>?> importCollection() async {
    if (state.client == null) {
      return null;
    }

    final List<Deal> deals = await getCollection();

    if (deals.isNotEmpty) {
      await ref.read(asyncLibraryProvider.notifier).setLibrary(deals);
    }

    state = state.copyWith(
      error: null,
    );

    return deals;
  }

  Future<void> importData() async {
    state = state.copyWith(
      isLoading: true,
    );

    try {
      await importWaitlist();
    } catch (error, stackTrace) {
      Logger().e(
        'Failed to import ITAD waitlist',
        error: error,
        stackTrace: stackTrace,
      );

      Sentry.captureException(
        error,
        stackTrace: stackTrace,
      );

      state = state.copyWith(
        error: error.toString(),
      );
    }

    try {
      await importCollection();
    } catch (error, stackTrace) {
      Logger().e(
        'Failed to import ITAD collection',
        error: error,
        stackTrace: stackTrace,
      );

      Sentry.captureException(
        error,
        stackTrace: stackTrace,
      );

      state = state.copyWith(
        error: error.toString(),
      );
    }

    state = state.copyWith(
      isLoading: false,
    );
  }
}

final itadProvider = NotifierProvider<ITADNotifier, ITADState>(() {
  return ITADNotifier();
});
