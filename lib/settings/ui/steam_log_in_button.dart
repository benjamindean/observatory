import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:observatory/shared/helpers/steam_openid.dart';
import 'package:url_launcher/url_launcher.dart';

class SteamLogInButton extends StatelessWidget {
  const SteamLogInButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: () async {
        OpenId openId = const OpenId();

        launchUrl(
          openId.authUrl(),
          mode: LaunchMode.externalApplication,
        );
      },
      label: const Text('Log In With Steam'),
      icon: const FaIcon(FontAwesomeIcons.steam),
    );
  }
}
