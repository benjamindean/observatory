import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:observatory/deal/deal_functions.dart';
import 'package:observatory/deal/ui/deal_bottom_sheet.dart';
import 'package:observatory/deal/ui/deal_card_compact_info_row.dart';
import 'package:observatory/settings/settings_provider.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/ui/observatory_card.dart';
import 'package:observatory/shared/widgets/header_image.dart';
import 'package:observatory/waitlist/waitlist_provider.dart';

const double delimiter = 3.4;

class DealCardCompact extends ConsumerWidget {
  final Deal deal;

  const DealCardCompact({
    super.key,
    required this.deal,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool showHeaders = ref.watch(
      asyncSettingsProvider.select(
        (value) => value.value?.showHeaders ?? false,
      ),
    );
    final List<String> waitlist = ref.watch(
      asyncWaitListProvider.select(
        (waitListState) => waitListState.value?.ids ?? [],
      ),
    );
    final bool isInWaitlist = waitlist.contains(deal.id);

    return SizedBox(
      height: showHeaders ? (IMAGE_HEIGHT / delimiter) + 8 : 80,
      width: double.infinity,
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.2,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {
                if (isInWaitlist) {
                  return addDealToWaitlist(
                    context: context,
                    ref: ref,
                    deal: deal,
                  );
                }

                return removeDealFromWaitlist(
                  context: context,
                  ref: ref,
                  deal: deal,
                );
              },
              backgroundColor: Colors.transparent,
              foregroundColor: context.colors.scheme.primary,
              icon: isInWaitlist ? Icons.favorite : Icons.favorite_outline,
            ),
          ],
        ),
        child: InkWell(
          splashColor: context.colors.scheme.primaryContainer,
          splashFactory: InkSparkle.splashFactory,
          borderRadius: BorderRadius.circular(16),
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
                    return DealBottomSheet(deal: deal);
                  },
                );
              },
            );
          },
          child: ObservatoryCard(
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
                      width: IMAGE_WIDTH / delimiter,
                      height: IMAGE_HEIGHT / delimiter,
                      child: HeaderImage(
                        url: deal.headerImageURL,
                        isCompact: true,
                      ),
                    );
                  },
                ),
                Expanded(
                  child: DealCardCompactInfoRow(deal: deal),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onCardTap(BuildContext context) {
    context.push('/deal', extra: deal);
  }
}
