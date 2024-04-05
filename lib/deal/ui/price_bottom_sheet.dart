import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:observatory/deal/ui/price_card.dart';
import 'package:observatory/shared/models/price.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class PriceBottomSheet extends ConsumerWidget {
  const PriceBottomSheet({
    super.key,
    required this.price,
  });

  final Price price;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          color: context.colors.scheme.surface,
          child: PriceCard(
            price: price,
          ),
        ),
        Container(
          color: context.colors.scheme.background,
          child: Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.open_in_browser,
                  color: context.colors.scheme.secondary,
                ),
                title: const Text('Open in Browser'),
                onTap: () {
                  launchUrl(
                    Uri.parse(price.url),
                    mode: LaunchMode.externalApplication,
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.share,
                  color: context.colors.scheme.secondary,
                ),
                title: const Text('Share Link'),
                onTap: () {
                  Share.share(
                    price.url.toString(),
                  );

                  context.pop();
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}