import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:observatory/itad_filters/itad_filters_page.dart';
import 'package:observatory/itad_filters/providers/itad_filters_provider.dart';
import 'package:observatory/settings/providers/settings_provider.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/models/itad_filters.dart';
import 'package:observatory/shared/ui/dot_separator.dart';

class ITADFiltersInfoBar extends ConsumerWidget {
  final DealCategory dealsTab;

  const ITADFiltersInfoBar({
    super.key,
    required this.dealsTab,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ITADFilters filters = ref.watch(
      itadFiltersProvider.select((value) => value.current),
    );
    final String currency = ref.watch(
      asyncSettingsProvider.select(
        (value) => value.valueOrNull?.currency ?? 'USD',
      ),
    );

    if (filters == const ITADFilters() || dealsTab != DealCategory.all) {
      return const SizedBox.shrink();
    }

    final List<String> tags = filters.tags ?? [];

    return GestureDetector(
      onTap: () => showITADFilters(context),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.colors.scheme.surface,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: ListTile(
            dense: true,
            leading: Icon(
              Icons.filter_list_sharp,
              color: context.colors.scheme.onSurfaceVariant,
            ),
            title: Text(
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
            subtitle: Text.rich(
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
                        ? '< ${NumberFormat.simpleCurrency(
                            name: currency,
                            decimalDigits: 0,
                          ).format(filters.price?.max)}'
                        : 'Any',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DotSeparator.textSpan(context),
                  const TextSpan(
                    text: 'Discount: ',
                  ),
                  TextSpan(
                    text: filters.cut != null
                        ? '> ${filters.cut?.min.toString()}%'
                        : 'Any',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DotSeparator.textSpan(context),
                  const TextSpan(
                    text: 'NSFW: ',
                  ),
                  TextSpan(
                    text: (filters.mature != null && filters.mature == true)
                        ? 'On'
                        : 'Off',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
