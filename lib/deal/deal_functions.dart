import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/bookmarks/providers/bookmarks_provider.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/models/price.dart';
import 'package:observatory/shared/ui/observatory_snack_bar.dart';
import 'package:observatory/waitlist/providers/waitlist_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class DealFunctions {
  static void shareDeal(Deal deal) {
    final Price? price = deal.prices?.firstOrNull;

    if (price != null) {
      Share.share(
        price.url.toString(),
        subject: '${deal.titleParsed} on ${price.shop.name}',
      );
    }
  }

  static void openDealLink(Deal deal) {
    final Price? price = deal.prices?.firstOrNull;

    if (price != null) {
      launchUrl(
        Uri.parse(price.url),
        mode: LaunchMode.externalApplication,
      );
    }
  }

  static void removeDealFromWaitlist({
    required BuildContext context,
    required WidgetRef ref,
    required Deal deal,
    bool showToast = true,
  }) async {
    final AsyncWaitListNotifier notifier = ref.watch(
      asyncWaitListProvider.notifier,
    );
    final Deal updatedDeal = deal.copyWith();

    HapticFeedback.mediumImpact();

    notifier.removeFromWaitList(updatedDeal);

    if (!showToast) {
      return;
    }

    return ObservatorySnackBar.show(
      context,
      onAction: () {
        notifier.addToWaitlist([updatedDeal]);
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
  }

  static void addDealToWaitlist({
    required BuildContext context,
    required WidgetRef ref,
    required Deal deal,
    bool showToast = true,
  }) async {
    final AsyncWaitListNotifier notifier = ref.watch(
      asyncWaitListProvider.notifier,
    );
    final Deal updatedDeal = deal.copyWith();

    HapticFeedback.mediumImpact();

    notifier.addToWaitlist([updatedDeal]);

    if (!showToast) {
      return;
    }

    return ObservatorySnackBar.show(
      context,
      onAction: () {
        notifier.removeFromWaitList(updatedDeal);
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
  }

  static void addBookmark({
    required BuildContext context,
    required WidgetRef ref,
    required Deal deal,
    bool showToast = true,
  }) async {
    final AsyncBookmarksNotifier notifier = ref.watch(
      asyncBookmarksProvider.notifier,
    );
    final Deal updatedDeal = deal.copyWith();

    HapticFeedback.mediumImpact();

    notifier.addBookmark(updatedDeal);

    if (!showToast) {
      return;
    }

    return ObservatorySnackBar.show(
      context,
      onAction: () {
        notifier.removeBookmarks([updatedDeal]);
      },
      icon: Icons.push_pin_rounded,
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
              text: ' has been pinned to the top of the list.',
              style: context.themes.snackBar.contentTextStyle?.copyWith(
                color: context.colors.scheme.onInverseSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void removeBookmark({
    required BuildContext context,
    required WidgetRef ref,
    required Deal deal,
    bool showToast = true,
  }) async {
    final AsyncBookmarksNotifier notifier = ref.watch(
      asyncBookmarksProvider.notifier,
    );
    final Deal updatedDeal = deal.copyWith();

    HapticFeedback.mediumImpact();

    notifier.removeBookmarks([updatedDeal]);

    if (!showToast) {
      return;
    }

    return ObservatorySnackBar.show(
      context,
      onAction: () {
        notifier.addBookmark(updatedDeal);
      },
      icon: Icons.push_pin_outlined,
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
              text: ' has been un-pinned from the top of the list.',
              style: context.themes.snackBar.contentTextStyle?.copyWith(
                color: context.colors.scheme.onInverseSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
