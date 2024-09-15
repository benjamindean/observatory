import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:observatory/settings/steam_import/steam_provider.dart';
import 'package:observatory/settings/steam_import/steam_state.dart';
import 'package:observatory/shared/helpers/steam_openid.dart';
import 'package:observatory/shared/widgets/progress_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';

class SteamLogInButton extends ConsumerWidget {
  const SteamLogInButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SteamState steamState = ref.watch(steamProvider);

    final List<Widget> widgets = [
      Expanded(
        child: FilledButton.icon(
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.fromLTRB(16.0, 4.0, 8.0, 4.0),
          ),
          onPressed: () async {
            if (steamState.steamUser != null) {
              ref.read(steamProvider.notifier).import();

              return;
            }

            OpenId openId = const OpenId();

            launchUrl(
              openId.authUrl(),
              mode: LaunchMode.externalApplication,
            );
          },
          label: steamState.steamUser != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              const TextSpan(
                                text: 'Sync from ',
                              ),
                              TextSpan(
                                text: steamState.steamUser!.personaname,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: context.colors.scheme.errorContainer,
                      ),
                      onPressed: () {
                        ref.read(steamProvider.notifier).unlinkSteamAccount();
                      },
                      child: Text(
                        'Log Out',
                        style: TextStyle(
                          color: context.colors.scheme.onErrorContainer,
                        ),
                      ),
                    )
                  ],
                )
              : const Text('Log In With Steam'),
          icon: steamState.isLoading
              ? ObservatoryProgressIndicator(
                  color: context.colors.scheme.onPrimary,
                  size: 23.0,
                )
              : const FaIcon(FontAwesomeIcons.steam),
        ),
      ),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widgets,
    );
  }
}
