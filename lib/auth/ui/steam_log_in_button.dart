import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:observatory/auth/providers/steam_provider.dart';
import 'package:observatory/auth/state/steam_state.dart';
import 'package:observatory/auth/providers/steam_openid.dart';
import 'package:observatory/auth/ui/log_in_button.dart';
import 'package:url_launcher/url_launcher.dart';

class SteamLogInButton extends ConsumerWidget {
  const SteamLogInButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SteamState steamState = ref.watch(steamProvider);

    return LogInButton(
      label: 'Steam',
      username: steamState.user?.personaname,
      isLoading: steamState.isLoading,
      color: const Color(0xFF66c0f4),
      iconBuilder: () {
        if (steamState.user != null && steamState.user!.avatarfull != null) {
          return CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
              steamState.user!.avatarfull!,
            ),
          );
        }

        return const Icon(
          FontAwesomeIcons.steam,
          size: 32,
        );
      },
      onPressed: () async {
        if (steamState.user != null) {
          ref.read(steamProvider.notifier).import();

          return;
        }

        OpenId openId = const OpenId();

        launchUrl(
          openId.authUrl(),
          mode: LaunchMode.externalApplication,
        );
      },
      onLogOut: () {
        ref.read(steamProvider.notifier).unlinkSteamAccount();
      },
      text: 'Log In With Steam',
    );
  }
}
