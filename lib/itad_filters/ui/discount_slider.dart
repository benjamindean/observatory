import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/itad_filters/providers/itad_filters_provider.dart';
import 'package:observatory/itad_filters/ui/min_cut_label.dart';
import 'package:observatory/shared/models/itad_filters.dart';

class DiscountSlider extends ConsumerWidget {
  const DiscountSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MinMax? cut = ref.watch(
      itadFiltersProvider.select((value) => value.cached.cut),
    );

    return Column(
      children: [
        ListTile(
          title: Text(
            'Discount',
            style: context.textStyles.titleMedium.copyWith(
              color: context.colors.scheme.onSurface,
            ),
          ),
          trailing: MinCutLabel(
            minCut: cut?.min,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Slider(
            label: '${cut?.min.toString() ?? FilterBounds.cut.min.toString()}%',
            value: cut?.min.toDouble() ?? 0,
            min: FilterBounds.cut.min.toDouble(),
            max: FilterBounds.cut.max.toDouble(),
            divisions: 20,
            onChanged: (value) {
              ref.read(itadFiltersProvider.notifier).setMinDiscount(value);
            },
          ),
        ),
      ],
    );
  }
}
