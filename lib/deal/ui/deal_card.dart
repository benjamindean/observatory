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
import 'package:observatory/library/providers/library_provider.dart';
import 'package:observatory/router.dart';
import 'package:observatory/settings/providers/settings_provider.dart';
import 'package:observatory/shared/constans.dart';
import 'package:observatory/shared/models/deal.dart';
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
    final bool muteGamesInLibrary = ref.watch(
      asyncSettingsProvider.select(
        (value) => value.valueOrNull?.muteGamesInLibrary ?? true,
      ),
    );
    final List<String> waitlist = ref.watch(waitlistIdsProvider);
    final List<String> bookmarks = ref.watch(bookmarkIdsProvider);
    final List<String> library = ref.watch(libraryIdsProvider);

    final bool isInWaitlist = waitlist.contains(deal.id);
    final bool isInBookmarks = bookmarks.contains(deal.id);
    final bool isInLibrary = library.contains(deal.id);

    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.4,
        motion: const ScrollMotion(),
        children: [
          CustomSlidableAction(
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
            child: Icon(
              size: 24.0,
              color: context.colors.scheme.primary,
              isInWaitlist
                  ? Icons.favorite_rounded
                  : Icons.favorite_outline_rounded,
            ),
          ),
          CustomSlidableAction(
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
            child: Icon(
              size: 24.0,
              color: context.colors.scheme.tertiary,
              isInBookmarks ? Icons.push_pin_rounded : Icons.push_pin_outlined,
            ),
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
              elevation: isInLibrary && muteGamesInLibrary ? 0.5 : null,
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
            Align(
              alignment: Alignment.topRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isWaitlistPage && isInWaitlist)
                    Icon(
                      Icons.favorite_rounded,
                      color: context.colors.scheme.primary,
                      size: context.textStyles.titleMedium.fontSize,
                    ),
                  if (isInBookmarks && isWaitlistPage)
                    Icon(
                      Icons.push_pin_rounded,
                      color: context.colors.scheme.tertiary,
                      size: context.textStyles.titleMedium.fontSize,
                    ),
                  if (isInLibrary)
                    Icon(
                      Icons.book,
                      color: context.colors.scheme.secondary,
                      size: context.textStyles.titleMedium.fontSize,
                    ),
                ],
              ),
            ),
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
