import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:observatory/auth/providers/steam_provider.dart';
import 'package:observatory/auth/state/steam_state.dart';
import 'package:observatory/auth/providers/steam_openid.dart';
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
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SizedBox(
            height: 54,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                backgroundColor: const Color(0xFF66c0f4),
              ),
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
              label: steamState.user != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Steam',
                                  style: TextStyle(
                                    fontSize:
                                        context.textStyles.labelSmall.fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text.rich(
                                  style: context.textStyles.labelLarge.copyWith(
                                    overflow: TextOverflow.ellipsis,
                                    color: context.colors.scheme.onPrimary,
                                  ),
                                  TextSpan(
                                    children: <TextSpan>[
                                      const TextSpan(
                                        text: 'Sync from ',
                                      ),
                                      TextSpan(
                                        text: steamState.user!.personaname,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
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
                  : const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 4.0),
                          child: Text(
                            'Log In With Steam',
                          ),
                        ),
                      ],
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
