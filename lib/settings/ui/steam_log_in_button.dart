import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:observatory/settings/steam_import/steam_import_provider.dart';
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
    final SteamState steamState = ref.watch(steamImportProvider);

    final List<Widget> widgets = [
      Expanded(
        child: SizedBox(
          height: 50,
          child: FilledButton.icon(
            onPressed: () async {
              if (steamState.steamUser != null) {
                ref.read(steamImportProvider.notifier).import();

                return;
              }

              OpenId openId = const OpenId();

              launchUrl(
                openId.authUrl(),
                mode: LaunchMode.externalApplication,
              );
            },
            label: steamState.steamUser != null
                ? Text('Sync With ${steamState.steamUser!.personaname}')
                : const Text('Log In With Steam'),
            icon: steamState.isLoading
                ? ObservatoryProgressIndicator(
                    color: context.colors.scheme.onPrimary,
                    size: 23.0,
                  )
                : const FaIcon(FontAwesomeIcons.steam),
          ),
        ),
      ),
    ];

    if (steamState.steamUser != null) {
      widgets.addAll(
        <Widget>[
          const SizedBox(width: 8),
          TextButton(
            onPressed: () {
              ref.read(steamImportProvider.notifier).unlinkSteamAccount();
            },
            child: const Text('Unlink Account'),
          )
        ].toList(),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widgets,
    );
  }
}
