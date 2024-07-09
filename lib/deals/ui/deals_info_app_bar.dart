import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/deals/providers/deals_provider.dart';
import 'package:observatory/deals/state/deals_state.dart';
import 'package:observatory/settings/settings_repository.dart';

class DealsInfoAppBar extends ConsumerWidget {
  final DealCategory dealsTab;

  const DealsInfoAppBar({
    super.key,
    required this.dealsTab,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<DealsState> deals = ref.watch(
      asyncDealsProvider(dealsTab),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dealCategoryLabels[dealsTab]?['title'] ?? 'Unknown',
          style: context.textStyles.labelLarge.copyWith(
            color: context.colors.scheme.onSurfaceVariant,
            fontWeight: FontWeight.bold,
          ),
        ),
        deals.when(
          data: (state) {
            final int discounted = state.deals
                .where((element) => element.bestPrice.cut > 0)
                .length;

            return Text.rich(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.themes.text.labelMedium?.copyWith(
                color: context.colors.hint,
              ),
              TextSpan(
                children: [
                  TextSpan(
                    text: discounted.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(text: ' of '),
                  TextSpan(
                    text: state.deals.length.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(text: ' discounted'),
                ],
              ),
            );
          },
          loading: () => Text(
            'Loading...',
            style: context.themes.text.labelMedium?.copyWith(
              color: context.colors.hint,
            ),
          ),
          error: (error, stackTrace) => Text(
            'No discounted games',
            style: context.themes.text.labelMedium?.copyWith(
              color: context.colors.hint,
            ),
          ),
        )
      ],
    );
  }
}
