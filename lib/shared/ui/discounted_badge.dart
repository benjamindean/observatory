import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/waitlist/providers/waitlist_provider.dart';

class DiscountedBadge extends ConsumerWidget {
  const DiscountedBadge({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Deal> waitlist =
        ref.watch(asyncWaitListProvider).valueOrNull ?? [];
    final int discountedCount =
        waitlist.where((deal) => deal.bestPrice.cut > 0).length;

    return Badge(
      key: const Key('discounted-badge'),
      backgroundColor: context.colors.scheme.secondary,
      alignment: Alignment.center,
      isLabelVisible: discountedCount > 0,
      offset: const Offset(20.0, -16.0),
      label: Text(
        discountedCount > 1000 ? '1000+' : discountedCount.toString(),
        style: context.textStyles.labelSmall.copyWith(
          color: context.colors.scheme.onSecondary,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: const Icon(Icons.favorite),
    );
  }
}
