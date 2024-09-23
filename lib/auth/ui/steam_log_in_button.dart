import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:observatory/settings/steam_import/steam_provider.dart';
import 'package:observatory/auth/steam_state.dart';
import 'package:observatory/auth/steam_openid.dart';
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

    Widget getIcon() {
      if (steamState.isLoading) {
        return ObservatoryProgressIndicator(
          color: context.colors.scheme.onPrimary,
          size: 26,
        );
      }

      if (steamState.steamUser != null &&
          steamState.steamUser!.avatarfull != null) {
        return CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(
            steamState.steamUser!.avatarfull!,
          ),
        );
      }

      return const Icon(
        FontAwesomeIcons.steam,
        size: 32,
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SizedBox(
            height: 48,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.all(8.0),
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
                            padding: const EdgeInsets.only(left: 4.0),
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
                            backgroundColor:
                                context.colors.scheme.errorContainer,
                            visualDensity: VisualDensity.compact,
                          ),
                          onPressed: () {
                            ref
                                .read(steamProvider.notifier)
                                .unlinkSteamAccount();
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
                  : const Padding(
                      padding: EdgeInsets.only(left: 4.0),
                      child: Text('Log In With Steam'),
                    ),
              icon: SizedBox(
                width: 32,
                height: 32,
                child: Center(
                  child: getIcon(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
