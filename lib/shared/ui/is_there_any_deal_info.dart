import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class IsThereAnyDealInfo extends StatelessWidget {
  const IsThereAnyDealInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: const Key('is_there_any_deal_info'),
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
      child: RichText(
        text: TextSpan(
          style: context.themes.text.labelMedium?.copyWith(
            color: context.colors.disabled,
          ),
          children: [
            const TextSpan(
              text: 'Information about current prices is provided by ',
            ),
            TextSpan(
              text: 'isThereAnyDeal.com',
              style: const TextStyle(fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  launchUrl(
                    Uri.parse('https://isthereanydeal.com/'),
                    mode: LaunchMode.externalApplication,
                  );
                },
            ),
            const TextSpan(
              text: '. All the other information is provided by ',
            ),
            TextSpan(
              text: 'IGDB.',
              style: const TextStyle(fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  launchUrl(
                    Uri.parse('https://igdb.com/'),
                    mode: LaunchMode.externalApplication,
                  );
                },
            )
          ],
        ),
      ),
    );
  }
}
