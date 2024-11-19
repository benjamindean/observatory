import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/deals/providers/deals_provider.dart';
import 'package:observatory/deals/state/deals_state.dart';
import 'package:observatory/itad_filters/providers/itad_filters_provider.dart';
import 'package:observatory/shared/constans.dart';

class DealsInfoAppBar extends ConsumerWidget {
  const DealsInfoAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<DealsState> deals = ref.watch(asyncDealsProvider);
    final String sortBy = ref.watch(
      itadFiltersProvider.select(
        (value) => value.current.sortBy ?? SortDealsBy.trending.name,
      ),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          SORT_BY_VALUES[SortDealsBy.values.byName(sortBy)] ??
              SortDealsBy.trending.name,
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
