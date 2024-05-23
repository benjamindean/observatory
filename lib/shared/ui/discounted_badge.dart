import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/waitlist/waitlist_provider.dart';

class DiscountedBadge extends ConsumerWidget {
  const DiscountedBadge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Deal> waitlist = ref.watch(
      asyncWaitListProvider.select(
        (value) => value.value?.deals ?? [],
      ),
    );
    final List<Deal> discountedDeals = waitlist
        .where(
          (element) => element.bestPrice.cut > 0,
        )
        .toList();

    return Badge(
      backgroundColor: context.colors.scheme.secondaryContainer,
      alignment: Alignment.center,
      isLabelVisible: discountedDeals.isNotEmpty,
      offset: const Offset(20.0, -8.0),
      label: discountedDeals.length > 100
          ? Text(
              '100+',
              style: context.textStyles.labelSmall.copyWith(
                color: context.colors.scheme.onSecondaryContainer,
              ),
            )
          : Text(discountedDeals.length.toString(),
              style: context.textStyles.labelSmall.copyWith(
                color: context.colors.scheme.onSecondaryContainer,
              )),
      child: const Icon(Icons.favorite),
    );
  }
}
