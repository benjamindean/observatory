import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/models/price.dart';
import 'package:observatory/waitlist/waitlist_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

void shareDeal(Deal deal) {
  final Price? price = deal.prices?.firstOrNull;

  if (price != null) {
    Share.share(
      price.url.toString(),
      subject: '${deal.titleParsed} on ${price.shop.name}',
    );
  }
}

void openDealLink(Deal deal) {
  final Price? price = deal.prices?.firstOrNull;

  if (price != null) {
    launchUrl(
      Uri.parse(price.url),
      mode: LaunchMode.externalApplication,
    );
  }
}

void addDealToWaitlist({
  required BuildContext context,
  required WidgetRef ref,
  required Deal deal,
  bool showToast = true,
}) async {
  final Deal updatedDeal = deal.copyWith();

  HapticFeedback.mediumImpact();

  await ref
      .read(asyncWaitListProvider.notifier)
      .removeFromWaitList(updatedDeal)
      .then(
    (value) {
      if (!showToast) {
        return;
      }

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () async {
              await ref
                  .watch(asyncWaitListProvider.notifier)
                  .addToWaitlist(updatedDeal);
            },
          ),
          content: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.remove_circle,
                  color: context.themes.snackBar.contentTextStyle!.color,
                ),
              ),
              Flexible(
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: deal.titleParsed,
                        style:
                            context.themes.snackBar.contentTextStyle!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' has been removed from your waitlist.',
                        style: context.themes.snackBar.contentTextStyle,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

void removeDealFromWaitlist({
  required BuildContext context,
  required WidgetRef ref,
  required Deal deal,
  bool showToast = true,
}) async {
  final Deal updatedDeal = deal.copyWith();

  HapticFeedback.mediumImpact();

  await ref
      .read(asyncWaitListProvider.notifier)
      .addToWaitlist(updatedDeal)
      .then(
    (value) {
      if (!showToast) {
        return;
      }

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () async {
              await ref
                  .watch(asyncWaitListProvider.notifier)
                  .removeFromWaitList(updatedDeal);
            },
          ),
          content: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.check_circle,
                  color: context.themes.snackBar.contentTextStyle!.color,
                ),
              ),
              Flexible(
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: deal.titleParsed,
                        style:
                            context.themes.snackBar.contentTextStyle!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' has been added to your waitlist.',
                        style: context.themes.snackBar.contentTextStyle,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
