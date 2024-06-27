import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:observatory/deals/providers/deals_provider.dart';
import 'package:observatory/itad_filters/providers/itad_filters_provider.dart';
import 'package:observatory/itad_filters/ui/max_price_label.dart';
import 'package:observatory/itad_filters/ui/min_cut_label.dart';
import 'package:observatory/settings/providers/settings_provider.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/models/itad_filters.dart';
import 'package:observatory/shared/ui/bottom_sheet_heading.dart';
import 'package:observatory/shared/ui/ory_small_button.dart';

void showITADFilters(BuildContext context) {
  showModalBottomSheet(
    useRootNavigator: true,
    useSafeArea: true,
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return const ITADFiltersPage();
    },
  );
}

class ITADFiltersPage extends ConsumerWidget {
  const ITADFiltersPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ITADFilters currentFilters = ref.read(
      itadFiltersProvider.select((value) => value.current),
    );
    final ITADFilters filters = ref.watch(
      itadFiltersProvider.select((value) => value.cached),
    );
    final String currency = ref.read(
      asyncSettingsProvider.select(
        (value) => value.valueOrNull?.currency ?? 'USD',
      ),
    );
    final bool isUpdated = filters != currentFilters;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BottomSheetHeading(
              text: 'Filters',
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OrySmallButton(
                    onPressed: isUpdated
                        ? () {
                            ref.watch(itadFiltersProvider.notifier).revert();
                          }
                        : null,
                    icon: Icons.restore_rounded,
                    label: 'Restore',
                    buttonColor: context.colors.scheme.tertiary,
                    textColor: context.colors.scheme.onTertiary,
                  ),
                  const SizedBox(
                    width: 6.0,
                  ),
                  OrySmallButton(
                    onPressed: isUpdated
                        ? () {
                            ref.watch(itadFiltersProvider.notifier).save();
                            ref
                                .watch(asyncDealsProvider(DealCategory.all)
                                    .notifier)
                                .reset(withLoading: true);

                            context.pop();
                          }
                        : null,
                    icon: Icons.check,
                    label: 'Apply',
                  ),
                ],
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              title: Text(
                'Tags',
                style: context.textStyles.titleMedium.copyWith(
                  color: context.colors.scheme.onSurface,
                ),
              ),
              subtitle: const Text('Filter by specific tags'),
              trailing: TextButton.icon(
                icon: const Icon(Icons.add_rounded),
                label: const Text('Add'),
                onPressed: () {
                  context.push('/tags-select');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                  children: filters.tags?.map(
                        (tag) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Chip(
                              side: BorderSide.none,
                              label: Text(
                                tag,
                                style: context.textStyles.labelMedium.copyWith(
                                  color: context.colors.scheme.onPrimary,
                                ),
                              ),
                              deleteIconColor: context.colors.scheme.onPrimary,
                              visualDensity: VisualDensity.compact,
                              backgroundColor: context.colors.scheme.primary,
                              onDeleted: () {
                                ref
                                    .watch(itadFiltersProvider.notifier)
                                    .removeTag(tag);
                              },
                            ),
                          );
                        },
                      ).toList() ??
                      []),
            ),
            ListTile(
              title: Text(
                'Price',
                style: context.textStyles.titleMedium.copyWith(
                  color: context.colors.scheme.onSurface,
                ),
              ),
              trailing: MaxPriceLabel(
                maxPrice: filters.price?.max,
                currency: currency,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Slider(
                value: filters.price?.max.toDouble() ??
                    FilterBounds.price.max.toDouble(),
                label: filters.price?.max.toString() ??
                    FilterBounds.price.max.toString(),
                min: FilterBounds.price.min.toDouble(),
                max: FilterBounds.price.max.toDouble(),
                divisions: 20,
                onChanged: (value) {
                  ref.watch(itadFiltersProvider.notifier).setMaxPrice(value);
                },
              ),
            ),
            ListTile(
              title: Text(
                'Discount',
                style: context.textStyles.titleMedium.copyWith(
                  color: context.colors.scheme.onSurface,
                ),
              ),
              trailing: MinCutLabel(
                minCut: filters.cut?.min,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Slider(
                label:
                    '${filters.cut?.min.toString() ?? FilterBounds.cut.min.toString()}%',
                value: filters.cut?.min.toDouble() ?? 0,
                min: FilterBounds.cut.min.toDouble(),
                max: FilterBounds.cut.max.toDouble(),
                divisions: 20,
                onChanged: (value) {
                  ref.watch(itadFiltersProvider.notifier).setMinDiscount(value);
                },
              ),
            ),
            SwitchListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              title: Text(
                'Bundled Only',
                style: context.textStyles.titleMedium.copyWith(
                  color: context.colors.scheme.onSurface,
                ),
              ),
              subtitle: Text(
                'Only show games that are currently bundled',
                style: context.textStyles.bodySmall.copyWith(
                  color: context.colors.scheme.onSurface,
                ),
              ),
              value: filters.bundled ?? false,
              onChanged: (value) {
                ref.watch(itadFiltersProvider.notifier).setBundled(value);
              },
            ),
            SwitchListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              title: Text(
                'NSFW Content',
                style: context.textStyles.titleMedium.copyWith(
                  color: context.colors.scheme.onSurface,
                ),
              ),
              subtitle: Text(
                'Show games with mature content',
                style: context.textStyles.bodySmall.copyWith(
                  color: context.colors.scheme.onSurface,
                ),
              ),
              value: filters.mature,
              onChanged: (value) {
                ref.watch(itadFiltersProvider.notifier).setNSFW(value);
              },
            ),
            SwitchListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              title: Text(
                'Non-deals',
                style: context.textStyles.titleMedium.copyWith(
                  color: context.colors.scheme.onSurface,
                ),
              ),
              subtitle: Text(
                'Show games that are not currently on sale',
                style: context.textStyles.bodySmall.copyWith(
                  color: context.colors.scheme.onSurface,
                ),
              ),
              value: filters.nondeals,
              onChanged: (value) {
                ref.watch(itadFiltersProvider.notifier).setNonDeals(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
