import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:observatory/deals/deals_provider.dart';
import 'package:observatory/deals/itad_filters_provider.dart';
import 'package:observatory/deals/ui/tags_list_page.dart';
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
    final ITADFilters filters = ref.watch(
      itadFiltersProvider,
    );

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
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
                            .watch(
                                asyncDealsProvider(DealCategory.all).notifier)
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
                  'Price',
                  style: context.textStyles.titleMedium.copyWith(
                    color: context.colors.scheme.onSurface,
                  ),
                ),
                trailing: Text(
                  '< ${filters.price?.max ?? 200}',
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
                  'Discount',
                  style: context.textStyles.titleMedium.copyWith(
                    color: context.colors.scheme.onSurface,
                  ),
                ),
                trailing: Text(
                  ' ${filters.cut?.min ?? 0}%',
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
                subtitle: const Text('Filter by specific tags'),
                trailing: TextButton.icon(
                  icon: const Icon(Icons.add_rounded),
                  label: const Text('Add'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const TagsListPage();
                        },
                      ),
                    );
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
                                  style:
                                      context.textStyles.labelMedium.copyWith(
                                    color: context.colors.scheme.onPrimary,
                                  ),
                                ),
                                deleteIconColor:
                                    context.colors.scheme.onPrimary,
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
      ),
    );
  }
}
