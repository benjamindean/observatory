import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:observatory/itad_filters/itad_filters_page.dart';
import 'package:observatory/settings/providers/settings_provider.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:observatory/shared/ui/bottom_sheet_heading.dart';
import 'package:observatory/shared/ui/close_bottom_sheet_button.dart';
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

class DealsFilter extends ConsumerWidget {
  const DealsFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DealCategory dealsTab = ref.watch(
          asyncSettingsProvider.select(
            (value) => value.valueOrNull?.dealsTab,
          ),
        ) ??
        DealCategory.all;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const BottomSheetHeading(
              text: 'Deals Type',
              trailing: CloseBottomSheetButton(),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: DealCategory.values.length,
              itemBuilder: (context, index) {
                final DealCategory category = DealCategory.values[index];
                final bool isSelected = DealCategory.values[index] == dealsTab;

                return ListTile(
                  key: Key('deal-category-${category.name.toString()}'),
                  selectedTileColor: context.colors.scheme.secondary,
                  selectedColor: context.colors.scheme.onSecondary,
                  selected: isSelected,
                  onTap: () async {
                    return ref
                        .read(asyncSettingsProvider.notifier)
                        .setDealsTab(category)
                        .then(
                      (value) {
                        if (context.mounted) {
                          context.pop();
                        }
                      },
                    );
                  },
                  title: Text(
                    dealCategoryLabels[category]?['title'] ?? 'Unknown',
                    style: context.textStyles.titleMedium.copyWith(
                      color: isSelected
                          ? context.colors.scheme.onSecondary
                          : context.colors.scheme.onSurface,
                    ),
                  ),
                  subtitle: Text(
                    dealCategoryLabels[category]?['subtitle'] ?? 'Unknown',
                    style: context.textStyles.bodySmall.copyWith(
                      color: isSelected
                          ? context.colors.scheme.onSecondary
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
