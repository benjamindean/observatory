import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/itad_filters/providers/itad_filters_provider.dart';
import 'package:observatory/itad_filters/ui/max_price_label.dart';
import 'package:observatory/settings/providers/itad_config_provider.dart';
import 'package:observatory/shared/models/itad_filters.dart';

class PriceSlider extends ConsumerWidget {
  const PriceSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MinMax? price = ref.watch(
      itadFiltersProvider.select((value) => value.cached.price),
    );
    final String currency = ref.read(
      itadConfigProvider.select(
        (value) => value.valueOrNull?.currency ?? 'USD',
      ),
    );

    return Column(
      children: [
        ListTile(
          title: Text(
            'Price',
            style: context.textStyles.titleMedium.copyWith(
              color: context.colors.scheme.onSurface,
            ),
          ),
          trailing: MaxPriceLabel(
            maxPrice: price?.max,
            currency: currency,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Slider(
            value: price?.max.toDouble() ?? FilterBounds.price.max.toDouble(),
            label: price?.max.toString() ?? FilterBounds.price.max.toString(),
            min: FilterBounds.price.min.toDouble(),
            max: FilterBounds.price.max.toDouble(),
            divisions: 20,
            onChanged: (value) {
              ref.read(itadFiltersProvider.notifier).setMaxPrice(value);
            },
          ),
        ),
      ],
    );
  }
}
