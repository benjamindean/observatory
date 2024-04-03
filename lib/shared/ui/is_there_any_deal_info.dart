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
    return ListTile(
      key: const Key('is_there_any_deal_info'),
      dense: true,
      subtitle: const Text(''),
      title: RichText(
        text: TextSpan(
          style: context.themes.text.labelMedium?.copyWith(
            color: context.colors.disabled,
          ),
          children: [
            const TextSpan(
              text:
                  'Information about current deals and prices is provided by ',
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
          ],
        ),
      ),
    );
  }
}
