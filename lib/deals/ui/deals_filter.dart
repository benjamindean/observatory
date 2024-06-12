import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:observatory/deals/deals_provider.dart';
import 'package:observatory/deals/itad_filters_provider.dart';
import 'package:observatory/settings/settings_provider.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:observatory/shared/models/itad_filters.dart';
import 'package:observatory/shared/ui/bottom_sheet_heading.dart';

void showDealsFilter(BuildContext context) {
  showModalBottomSheet(
    useRootNavigator: true,
    useSafeArea: true,
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return const DealsFilter();
    },
  );
}

class DealsFilter extends ConsumerWidget {
  const DealsFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DealCategory dealsTab = ref.watch(
          asyncSettingsProvider.select(
            (value) => value.valueOrNull?.dealsTab,
          ),
        ) ??
        DealCategory.steam_top_sellers;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BottomSheetHeading(text: 'Deals Type'),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: DealCategory.values.length,
              itemBuilder: (context, index) {
                final DealCategory category = DealCategory.values[index];
                final bool isSelected = DealCategory.values[index] == dealsTab;

                return ListTile(
                  selectedTileColor: context.colors.scheme.secondaryContainer,
                  selectedColor: context.colors.scheme.onSecondaryContainer,
                  selected: isSelected,
                  onTap: () async {
                    return ref
                        .read(asyncSettingsProvider.notifier)
                        .setDealsTab(category)
                        .then(
                          (value) => context.pop(),
                        );
                  },
                  title: Text(
                    dealCategoryLabels[category]?['title'] ?? 'Unknown',
                    style: context.textStyles.titleMedium.copyWith(
                      color: isSelected
                          ? context.colors.scheme.onSecondaryContainer
                          : context.colors.scheme.onSurface,
                    ),
                  ),
                  subtitle: Text(
                    dealCategoryLabels[category]?['subtitle'] ?? 'Unknown',
                    style: context.textStyles.bodySmall.copyWith(
                      color: isSelected
                          ? context.colors.scheme.onSecondaryContainer
                          : context.colors.scheme.onSurface,
                    ),
                  ),
                  trailing: category == DealCategory.all && isSelected
                      ? GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              barrierColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return const ITADFiltersPage();
                              },
                            );
                          },
                          child: Chip(
                            side: BorderSide.none,
                            avatar: Icon(
                              Icons.keyboard_arrow_up_rounded,
                              color: context.colors.scheme.onSecondary,
                            ),
                            label: Text(
                              'More Filters',
                              style: context.textStyles.labelMedium.copyWith(
                                color: context.colors.scheme.onSecondary,
                              ),
                            ),
                            backgroundColor: context.colors.scheme.secondary,
                          ),
                        )
                      : null,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ITADFiltersPage extends ConsumerWidget {
  const ITADFiltersPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ITADFilters filters = ref.watch(
      itadFiltersProvider,
    );

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
                  FilledButton.icon(
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.fromLTRB(8.0, 8.0, 16.0, 8.0),
                      ),
                      visualDensity: VisualDensity.compact,
                      backgroundColor: WidgetStateProperty.all(
                        context.colors.scheme.tertiary,
                      ),
                    ),
                    onPressed: () {
                      ref.watch(itadFiltersProvider.notifier).reset();
                    },
                    icon: Icon(
                      Icons.restore_rounded,
                      color: context.colors.scheme.onTertiary,
                    ),
                    label: Text(
                      'Reset',
                      style: context.textStyles.labelMedium.copyWith(
                        color: context.colors.scheme.onTertiary,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 6.0,
                  ),
                  FilledButton.icon(
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.fromLTRB(8.0, 8.0, 16.0, 8.0),
                      ),
                      visualDensity: VisualDensity.compact,
                      backgroundColor: WidgetStateProperty.all(
                        context.colors.scheme.primary,
                      ),
                    ),
                    onPressed: () {
                      ref.watch(itadFiltersProvider.notifier).save();
                      ref
                          .watch(asyncDealsProvider(DealCategory.all).notifier)
                          .reset(withLoading: true);

                      context.pop();
                      context.pop();
                    },
                    icon: Icon(
                      Icons.check,
                      color: context.colors.scheme.onPrimary,
                    ),
                    label: Text(
                      'Apply',
                      style: context.textStyles.labelMedium.copyWith(
                        color: context.colors.scheme.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(
                'Max Price',
                style: context.textStyles.titleMedium.copyWith(
                  color: context.colors.scheme.onSurface,
                ),
              ),
              trailing: Text(
                '${filters.price?.max ?? 200}',
                style: context.textStyles.titleMedium.copyWith(
                  color: context.colors.scheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Slider(
                value: filters.price?.max?.toDouble() ?? 200,
                label: filters.price?.max.toString() ?? '200',
                min: 0,
                max: 200,
                divisions: 20,
                onChanged: (value) {
                  ref.watch(itadFiltersProvider.notifier).update(
                        filters.copyWith(
                          price: MinMax(
                            min: 0,
                            max: value.toInt(),
                          ),
                        ),
                      );
                },
              ),
            ),
            ListTile(
              title: Text(
                'Min Price Cut',
                style: context.textStyles.titleMedium.copyWith(
                  color: context.colors.scheme.onSurface,
                ),
              ),
              trailing: Text(
                '${filters.cut?.min ?? 0}%',
                style: context.textStyles.titleMedium.copyWith(
                  color: context.colors.scheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Slider(
                label: '${filters.cut?.min.toString() ?? '0'}%',
                value: filters.cut?.min?.toDouble() ?? 0,
                min: 0,
                max: 100,
                divisions: 20,
                onChanged: (value) {
                  ref.watch(itadFiltersProvider.notifier).update(
                        filters.copyWith(
                          cut: MinMax(
                            min: value.toInt(),
                            max: 100,
                          ),
                        ),
                      );
                },
              ),
            ),
            SwitchListTile(
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
                ref.watch(itadFiltersProvider.notifier).update(
                      filters.copyWith(
                        bundled: value,
                      ),
                    );
              },
            )
          ],
        ),
      ),
    );
  }
}
