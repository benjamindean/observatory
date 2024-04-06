import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/settings/settings_provider.dart';
import 'package:observatory/settings/settings_repository.dart';

void showWaitlistSorting(BuildContext context) {
  showModalBottomSheet(
    useRootNavigator: true,
    useSafeArea: true,
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return const WaitlistSortingPage();
    },
  );
}

final textLabels = {
  WaitlistSorting.date_added: {
    'title': 'Date Added',
    WaitlistSortingDirection.asc: 'New to Old',
    WaitlistSortingDirection.desc: 'Old to New',
  },
  WaitlistSorting.price: {
    'title': 'Price',
    WaitlistSortingDirection.asc: 'High to Low',
    WaitlistSortingDirection.desc: 'Low to High',
  },
  WaitlistSorting.price_cut: {
    'title': 'Discount',
    WaitlistSortingDirection.asc: 'High to Low',
    WaitlistSortingDirection.desc: 'Low to High',
  },
  WaitlistSorting.title: {
    'title': 'Title',
    WaitlistSortingDirection.asc: 'A to Z',
    WaitlistSortingDirection.desc: 'Z to A',
  },
};

class WaitlistSortingPage extends ConsumerWidget {
  const WaitlistSortingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final WaitlistSortingDirection waitlistSortingDirection = ref.watch(
      asyncSettingsProvider.select(
        (value) => value.requireValue.waitlistSortingDirection,
      ),
    );
    final WaitlistSorting waitlistSorting = ref.watch(
      asyncSettingsProvider.select(
        (value) => value.requireValue.waitlistSorting,
      ),
    );

    return Wrap(
      children: [
        SingleChildScrollView(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: WaitlistSorting.values.length,
            itemBuilder: (context, index) {
              final WaitlistSorting sorting = WaitlistSorting.values[index];

              return ListTile(
                contentPadding: const EdgeInsets.fromLTRB(16, 0, 12, 0),
                selectedTileColor: context.colors.scheme.primaryContainer,
                selectedColor: context.colors.scheme.onPrimaryContainer,
                selected: sorting == waitlistSorting,
                onTap: () async {
                  ref
                      .read(asyncSettingsProvider.notifier)
                      .setWaitlistSorting(sorting);

                  if (sorting == waitlistSorting) {
                    ref
                        .read(asyncSettingsProvider.notifier)
                        .setWaitlistSortingDirection(
                          waitlistSortingDirection ==
                                  WaitlistSortingDirection.asc
                              ? WaitlistSortingDirection.desc
                              : WaitlistSortingDirection.asc,
                        );
                  }
                },
                title: Text(
                  textLabels[sorting]?['title'] ?? 'Price',
                  style: context.textStyles.titleMedium.copyWith(
                    color: context.colors.scheme.onPrimaryContainer,
                  ),
                ),
                trailing: Builder(
                  builder: (context) {
                    if (sorting == waitlistSorting) {
                      return Chip(
                        side: BorderSide.none,
                        label: Text(
                          textLabels[sorting]?[waitlistSortingDirection] ??
                              'Unknown',
                          style: context.textStyles.labelMedium.copyWith(
                            color: context.colors.scheme.onPrimary,
                          ),
                        ),
                        backgroundColor: context.colors.scheme.primary,
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
