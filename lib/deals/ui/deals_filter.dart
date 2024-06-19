import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:observatory/deals/deals_provider.dart';
import 'package:observatory/deals/itad_filters_provider.dart';
import 'package:observatory/settings/settings_provider.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:observatory/shared/models/itad_filters.dart';
import 'package:observatory/shared/steam_tags_listdart.dart';
import 'package:observatory/shared/ui/bottom_sheet_heading.dart';
import 'package:observatory/shared/ui/ory_small_button.dart';

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
          mainAxisSize: MainAxisSize.min,
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
                  trailing: category == DealCategory.all
                      ? OrySmallButton(
                          icon: Icons.keyboard_arrow_up_rounded,
                          label: 'More Filters',
                          buttonColor: context.colors.scheme.tertiary,
                          textColor: context.colors.scheme.onTertiary,
                          onPressed: isSelected
                              ? () {
                                  context.pop();
                                  showITADFilters(context);
                                }
                              : null,
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
                  OrySmallButton(
                    onPressed: () {
                      ref.watch(itadFiltersProvider.notifier).reset();
                    },
                    icon: Icons.restore_rounded,
                    label: 'Reset',
                    buttonColor: context.colors.scheme.secondary,
                    textColor: context.colors.scheme.onSecondary,
                  ),
                  const SizedBox(
                    width: 6.0,
                  ),
                  OrySmallButton(
                    onPressed: () {
                      ref.watch(itadFiltersProvider.notifier).save();
                      ref
                          .watch(asyncDealsProvider(DealCategory.all).notifier)
                          .reset(withLoading: true);

                      context.pop();
                    },
                    icon: Icons.check,
                    label: 'Apply',
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
            ListTile(
              title: Text(
                'Tags',
                style: context.textStyles.titleMedium.copyWith(
                  color: context.colors.scheme.onSurface,
                ),
              ),
              subtitle: const Text('Select tags to filter by'),
              trailing: TextButton(
                child: const Text('Select'),
                onPressed: () {
                  showAdaptiveDialog(
                    context: context,
                    builder: (context) {
                      return Scaffold(
                        body: Autocomplete<String>(
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            if (textEditingValue.text.trim().isEmpty) {
                              return const Iterable<String>.empty();
                            }

                            return steamTags.where((String option) {
                              return option.toString().contains(
                                  textEditingValue.text.toLowerCase());
                            });
                          },
                        ),
                      );
                    },
                  );
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
