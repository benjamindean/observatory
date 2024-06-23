import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:observatory/deal/deal_functions.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/waitlist/providers/waitlist_provider.dart';

class DealBottomSheet extends ConsumerWidget {
  const DealBottomSheet({
    super.key,
    required this.deal,
  });

  final Deal deal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> waitlist = ref.watch(
      asyncWaitListProvider.select(
        (waitListState) => waitListState.value?.ids ?? [],
      ),
    );
    final bool isInWaitlist = waitlist.contains(deal.id);

    return ColoredBox(
      color: context.colors.scheme.surface,
      child: SafeArea(
        child: ColoredBox(
          color: context.colors.scheme.surfaceContainer,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  deal.titleParsed,
                  style: context.themes.text.titleMedium?.copyWith(
                    color: context.colors.scheme.onSurface,
                  ),
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: context.colors.scheme.surface,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        isInWaitlist ? Icons.favorite : Icons.favorite_border,
                        color: context.colors.primary,
                      ),
                      title: Text(
                        isInWaitlist
                            ? 'Remove from Waitlist'
                            : 'Add to Waitlist',
                      ),
                      onTap: () {
                        if (isInWaitlist) {
                          return addDealToWaitlist(
                            context: context,
                            ref: ref,
                            deal: deal,
                            showToast: false,
                          );
                        }

                        return removeDealFromWaitlist(
                          context: context,
                          ref: ref,
                          deal: deal,
                          showToast: false,
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.open_in_browser,
                        color: context.colors.scheme.secondary,
                      ),
                      title: const Text('Open in Browser'),
                      onTap: deal.prices?.firstOrNull != null
                          ? () {
                              openDealLink(deal);
                              context.pop();
                            }
                          : null,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.share,
                        color: context.colors.scheme.tertiary,
                      ),
                      title: const Text('Share Link'),
                      onTap: deal.prices?.firstOrNull != null
                          ? () {
                              shareDeal(deal);

                              context.pop();
                            }
                          : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
