import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/search/search_provider.dart';
import 'package:observatory/search/search_state.dart';
import 'package:observatory/search/ui/search_input.dart';
import 'package:observatory/settings/settings_provider.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/widgets/settings_button.dart';
import 'package:observatory/waitlist/ui/waitlist_info_app_bar.dart';
import 'package:observatory/waitlist/ui/waitlist_sorting_page.dart';
import 'package:observatory/waitlist/ui/waitlist_sorting_strings.dart';

class WaitlistAppBar extends ConsumerWidget {
  const WaitlistAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SearchState searchState = ref.watch(filterResultsProvider);
    final WaitlistSortingDirection waitlistSortingDirection = ref.watch(
          asyncSettingsProvider.select(
            (value) => value.valueOrNull?.waitlistSortingDirection,
          ),
        ) ??
        WaitlistSortingDirection.asc;
    final WaitlistSorting waitlistSorting = ref.watch(
          asyncSettingsProvider.select(
            (value) => value.valueOrNull?.waitlistSorting,
          ),
        ) ??
        WaitlistSorting.date_added;

    if (searchState.isOpen) {
      return SliverAppBar(
        surfaceTintColor: context.colors.scheme.surfaceTint,
        floating: true,
        titleSpacing: 0.0,
        title: SearchInput(
          searchType: SearchType.filter,
          onChanged: (String value) {
            ref.read(filterResultsProvider.notifier).setQuery(
                  value.trim(),
                );
          },
        ),
      );
    }

    return SliverAppBar(
      surfaceTintColor: context.colors.scheme.surfaceTint,
      floating: true,
      flexibleSpace: AppBar(
        title: GestureDetector(
          onTap: () {
            PrimaryScrollController.of(context).animateTo(
              0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeIn,
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    waitlistSortingStrings[waitlistSorting]?['title'] ??
                        waitlistSortingStrings[WaitlistSorting.date_added]![
                            'title']!,
                    style: context.textStyles.labelLarge.copyWith(
                      color: context.colors.scheme.onSurfaceVariant,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4.0),
                  Icon(
                    waitlistSortingDirection == WaitlistSortingDirection.desc
                        ? Icons.arrow_upward_rounded
                        : Icons.arrow_downward_rounded,
                    size: 16,
                    color: context.colors.scheme.onSurfaceVariant,
                  )
                ],
              ),
              const WaitlistInfoAppBar(),
            ],
          ),
        ),
        actions: [
          FilledButton.icon(
            style: FilledButton.styleFrom(
              side: BorderSide.none,
              visualDensity: VisualDensity.compact,
            ),
            onPressed: () => showWaitlistSorting(context),
            icon: const Icon(
              Icons.sort,
              size: 16.0,
            ),
            label: Text(
              'Sort',
              style: context.textStyles.labelLarge.copyWith(
                color: context.colors.scheme.onPrimary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                ref.read(filterResultsProvider.notifier).setIsOpen();
              },
              icon: const Icon(Icons.search),
            ),
          ),
          const SettingsButton(),
        ],
      ),
    );
  }
}
