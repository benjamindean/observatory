import 'dart:async';

import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:observatory/bookmarks/providers/bookmarks_provider.dart';
import 'package:observatory/deal/deal_functions.dart';
import 'package:observatory/deal/ui/deal_bottom_sheet.dart';
import 'package:observatory/deal/ui/deal_card_info_row.dart';
import 'package:observatory/router.dart';
import 'package:observatory/settings/providers/settings_provider.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/ui/constants.dart';
import 'package:observatory/shared/ui/observatory_card.dart';
import 'package:observatory/shared/widgets/header_image.dart';
import 'package:observatory/waitlist/providers/waitlist_provider.dart';

class DealCard extends ConsumerWidget {
  final Deal deal;
  final NavigationBranch page;
  final Function? onCardTapCallback;

  const DealCard({
    super.key,
    required this.deal,
    required this.page,
    this.onCardTapCallback,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isWaitlistPage = page == NavigationBranch.waitlist;
    final bool showHeaders = ref.watch(
      asyncSettingsProvider.select(
        (value) => value.valueOrNull?.showHeaders ?? false,
      ),
    );
    final List<String> waitlist = ref.watch(waitlistIdsProvider);
    final List<String> bookmarks = ref.watch(bookmarkIdsProvider);

    final bool isInWaitlist = waitlist.contains(deal.id);
    final bool isInBookmarks = bookmarks.contains(deal.id);

    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.4,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            padding: EdgeInsets.zero,
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            backgroundColor: Colors.transparent,
            onPressed: (_) {
              if (isInWaitlist) {
                return DealFunctions.removeDealFromWaitlist(
                  context: context,
                  ref: ref,
                  deal: deal,
                );
              }

              return DealFunctions.addDealToWaitlist(
                context: context,
                ref: ref,
                deal: deal,
              );
            },
            foregroundColor: context.colors.scheme.primary,
            icon: isInWaitlist
                ? Icons.favorite_rounded
                : Icons.favorite_outline_rounded,
          ),
          SlidableAction(
            padding: EdgeInsets.zero,
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            onPressed: (_) {
              if (!isInWaitlist) {
                DealFunctions.addDealToWaitlist(
                  context: context,
                  ref: ref,
                  deal: deal,
                );
              }

              if (isInBookmarks) {
                return DealFunctions.removeBookmark(
                  context: context,
                  ref: ref,
                  deal: deal,
                );
              }

              return DealFunctions.addBookmark(
                context: context,
                ref: ref,
                deal: deal,
              );
            },
            backgroundColor: Colors.transparent,
            foregroundColor: context.colors.scheme.tertiary,
            icon: isInBookmarks
                ? Icons.push_pin_rounded
                : Icons.push_pin_outlined,
          ),
        ],
      ),
      child: InkWell(
        splashColor: context.colors.scheme.primaryContainer,
        splashFactory: InkSparkle.splashFactory,
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        onTap: () => onCardTap(context),
        onLongPress: () {
          HapticFeedback.mediumImpact();

          showModalBottomSheet(
            context: context,
            useRootNavigator: true,
            useSafeArea: true,
            builder: (BuildContext context) {
              return Consumer(
                builder: (context, ref, _) {
                  return DealBottomSheet(
                    deal: deal,
                  );
                },
              );
            },
          );
        },
        child: Stack(
          children: [
            ObservatoryCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Builder(
                    builder: (context) {
                      if (!showHeaders) {
                        return const SizedBox.shrink();
                      }

                      return SizedBox(
                        width: THUMB_WIDTH,
                        height: THUMB_HEIGHT,
                        child: HeaderImage(
                          url: deal.headerImageURL,
                          isCompact: true,
                        ),
                      );
                    },
                  ),
                  Expanded(
                    child: DealCardInfoRow(deal: deal),
                  ),
                ],
              ),
            ),
            if (!isWaitlistPage && isInWaitlist)
              Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.favorite_rounded,
                  color: context.colors.scheme.primary,
                  size: context.textStyles.titleMedium.fontSize,
                ),
              ),
            if (isInBookmarks && isWaitlistPage)
              Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.push_pin_rounded,
                  color: context.colors.scheme.tertiary,
                  size: context.textStyles.titleMedium.fontSize,
                ),
              )
          ],
        ),
      ),
    );
  }

  void onCardTap(BuildContext context) {
    context.push('/deal', extra: deal);

    if (onCardTapCallback != null) {
      unawaited(onCardTapCallback!());
    }
  }
}
