import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/waitlist/waitlist_provider.dart';
import 'package:observatory/waitlist/waitlist_state.dart';

class DiscountedBadge extends ConsumerWidget {
  const DiscountedBadge({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final WaitListState? waitlist =
        ref.watch(asyncWaitListProvider).valueOrNull;
    final int discountedCount = waitlist?.discountedDeals.length ?? 0;

    return Badge(
      key: const Key('discounted-badge'),
      backgroundColor: context.colors.scheme.secondaryContainer,
      alignment: Alignment.center,
      isLabelVisible: discountedCount > 0,
      offset: const Offset(20.0, -8.0),
      label: Text(
        discountedCount > 1000 ? '1000+' : discountedCount.toString(),
        style: context.textStyles.labelSmall.copyWith(
          color: context.colors.scheme.onSecondaryContainer,
        ),
      ),
      child: const Icon(Icons.favorite),
    );
  }
}
