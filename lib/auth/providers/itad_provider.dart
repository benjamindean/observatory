import 'dart:convert';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:observatory/auth/itad_state.dart';
import 'package:oauth2/oauth2.dart';
import 'package:observatory/secret_loader.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/waitlist/providers/waitlist_provider.dart';

final String identifier = GetIt.I<Secret>().itadApiIdentifier;
final String secret = GetIt.I<Secret>().itadApiSecret;

final Uri redirectUrl = Uri.parse(
  'https://getobservatory.app/app/auth/itad',
);

class ITADNotifier extends Notifier<ITADState> {
  @override
  ITADState build() {
    final ITADUser? user = GetIt.I<SettingsRepository>().getITADUser();

    if (user != null && user.credentials != null) {
      return ITADState(
        itadUser: user,
        client: Client(
          Credentials.fromJson(
            user.credentials!,
          ),
          identifier: identifier,
          secret: secret,
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
      identifier,
      Uri.parse(
        'https://isthereanydeal.com/oauth/authorize/',
      ),
      Uri.parse(
        'https://isthereanydeal.com/oauth/token/',
      ),
      secret: secret,
    );

    state = state.copyWith(
      grant: grant,
    );

    return grant;
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
      scopes: [
        'user_info',
        'notes_read',
        'notes_write',
        'profiles',
        'wait_read',
        'wait_write',
        'coll_read',
        'coll_write',
      ],
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

      final String userResponse = await client.read(
        Uri.parse('https://api.isthereanydeal.com/user/info/v2'),
      );

      final ITADUser user = ITADUser(
        username: json.decode(userResponse)['username'],
        credentials: client.credentials.toJson(),
      );

      await GetIt.I<SettingsRepository>().setITADUser(user);

      state = ITADState(
        itadUser: user,
        client: client,
        isLoading: false,
        grant: null,
      );
    } catch (error, stackTrace) {
      Logger().e(error, stackTrace: stackTrace);

      state = state.copyWith(
        isLoading: false,
        error: 'Failed to authenticate with ITAD',
        grant: null,
      );
    }
  }

  Future<void> unlinkAccount() async {
    final AuthorizationCodeGrant grant = getGrant();

    grant.close();

    await GetIt.I<SettingsRepository>().setITADUser(null);

    state = const ITADState();
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
        .map<Deal>((deal) => Deal.fromJson(deal))
        .toList();
  }

  Future<List<Deal>?> import() async {
    if (state.client == null) {
      return null;
    }

    state = state.copyWith(
      isLoading: true,
    );

    try {
      final List<Deal> deals = await getWaitlist();

      if (deals.isNotEmpty) {
        await GetIt.I<SettingsRepository>().saveDeals(deals.toList());
        await ref.watch(asyncWaitListProvider.notifier).reset();
        await ref.read(itadProvider.notifier).addToWaitlist(
              ref.watch(waitlistIdsProvider),
            );
      }

      state = state.copyWith(
        isLoading: false,
        error: null,
      );

      return deals;
    } catch (error, stackTrace) {
      Logger().e(
        'Failed to import IsThereAnyDeal wishlist',
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

final itadProvider = NotifierProvider<ITADNotifier, ITADState>(() {
  return ITADNotifier();
});
