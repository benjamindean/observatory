import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:observatory/itad_filters/providers/itad_filters_provider.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/helpers/currency_setter.dart';
import 'package:observatory/shared/models/itad_filters.dart';
import 'package:observatory/shared/ui/dot_separator.dart';

class ITADFiltersInfoAppBar extends ConsumerWidget {
  const ITADFiltersInfoAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ITADFilters filters = ref.watch(
      itadFiltersProvider.select((value) => value.current),
    );

    final List<String> tags = filters.tags ?? [];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tags.isNotEmpty
              ? tags.join(', ')
              : dealCategoryLabels[DealCategory.all]?['title'] ?? 'Unknown',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.textStyles.labelLarge.copyWith(
            color: context.colors.scheme.onSurfaceVariant,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text.rich(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.themes.text.labelMedium?.copyWith(
            color: context.colors.hint,
          ),
          TextSpan(
            children: [
              const TextSpan(
                text: 'Price: ',
              ),
              TextSpan(
                text: filters.price != null
                    ? NumberFormat.simpleCurrency(
                        name: GetIt.I<Currency>().name,
                        decimalDigits: 0,
                      ).format(filters.price?.max)
                    : 'Any',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              DotSeparator.textSpan(context),
              const TextSpan(text: 'Discount: '),
              TextSpan(
                text: filters.cut != null
                    ? '${filters.cut?.min.toString()}%'
                    : 'Any',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
