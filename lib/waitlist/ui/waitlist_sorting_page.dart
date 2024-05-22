import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/settings/settings_provider.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/ui/bottom_sheet_heading.dart';
import 'package:observatory/waitlist/ui/steam_import_list_tile.dart';
import 'package:observatory/waitlist/ui/waitlist_sorting_strings.dart';

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

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const BottomSheetHeading(text: 'Sort By'),
            ListView.builder(
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
                    waitlistSortingStrings[sorting]?['title'] ?? 'Price',
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
                            waitlistSortingStrings[sorting]
                                    ?[waitlistSortingDirection] ??
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
            const BottomSheetHeading(text: 'Steam Import'),
            const SteamImportListTile(),
          ],
        ),
      ),
    );
  }
}
