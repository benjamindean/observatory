import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:observatory/settings/settings_provider.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';

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
        (value) => value.requireValue.dealsTab,
      ),
    );

    return Wrap(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: DealCategory.values.length,
          itemBuilder: (context, index) {
            final DealCategory category = DealCategory.values[index];

            return ListTile(
              selectedTileColor: context.colors.scheme.primaryContainer,
              selectedColor: context.colors.scheme.onPrimaryContainer,
              selected: DealCategory.values[index] == dealsTab,
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
                  color: context.colors.scheme.onPrimaryContainer,
                ),
              ),
              subtitle: Text(
                dealCategoryLabels[category]?['subtitle'] ?? 'Unknown',
                style: context.textStyles.bodySmall.copyWith(
                  color: context.colors.scheme.onPrimaryContainer,
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
