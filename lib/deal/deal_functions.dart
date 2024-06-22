import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/models/price.dart';
import 'package:observatory/shared/ui/observatory_snack_bar.dart';
import 'package:observatory/waitlist/providers/waitlist_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

void shareDeal(Deal deal) {
  final Price? price = deal.prices?.firstOrNull;

  if (price != null) {
    FirebaseAnalytics.instance.logShare(
      contentType: 'deal',
      itemId: deal.id,
      method: 'manual',
      parameters: {
        'id': deal.id,
        'title': deal.titleParsed,
      },
    );

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
      FirebaseAnalytics.instance.logEvent(
        name: 'waitlist_add',
        parameters: {
          'id': updatedDeal.id,
          'title': updatedDeal.titleParsed,
        },
      );

      if (!showToast) {
        return;
      }

      return ObservatorySnackBar.show(
        context,
        onAction: () async {
          await ref
              .watch(asyncWaitListProvider.notifier)
              .addToWaitlist(updatedDeal);
        },
        icon: Icons.remove_circle,
        content: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: deal.titleParsed,
                style: context.themes.snackBar.contentTextStyle?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colors.scheme.onInverseSurface,
                ),
              ),
              TextSpan(
                text: ' has been removed from your waitlist.',
                style: context.themes.snackBar.contentTextStyle?.copyWith(
                  color: context.colors.scheme.onInverseSurface,
                ),
              ),
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
      FirebaseAnalytics.instance.logEvent(
        name: 'waitlist_remove',
        parameters: {
          'id': updatedDeal.id,
          'title': updatedDeal.titleParsed,
        },
      );

      if (!showToast) {
        return;
      }

      return ObservatorySnackBar.show(
        context,
        onAction: () async {
          await ref
              .watch(asyncWaitListProvider.notifier)
              .removeFromWaitList(updatedDeal);
        },
        icon: Icons.add_circle_outlined,
        content: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: deal.titleParsed,
                style: context.themes.snackBar.contentTextStyle?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colors.scheme.onInverseSurface,
                ),
              ),
              TextSpan(
                text: ' has been added to your waitlist.',
                style: context.themes.snackBar.contentTextStyle?.copyWith(
                  color: context.colors.scheme.onInverseSurface,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
