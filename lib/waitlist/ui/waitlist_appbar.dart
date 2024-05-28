import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/search/search_provider.dart';
import 'package:observatory/search/search_state.dart';
import 'package:observatory/search/ui/search_input.dart';
import 'package:observatory/settings/settings_provider.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/widgets/settings_button.dart';
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
        (value) => value.requireValue.waitlistSortingDirection,
      ),
    );
    final WaitlistSorting waitlistSorting = ref.watch(
      asyncSettingsProvider.select(
        (value) => value.requireValue.waitlistSorting,
      ),
    );

    return SliverAppBar(
      floating: true,
      titleSpacing: 0.0,
      title: Builder(
        builder: (context) {
          if (searchState.isOpen) {
            return PopScope(
              canPop: !searchState.isOpen,
              onPopInvoked: (bool canPop) {
                if (!canPop) {
                  ref.watch(filterResultsProvider.notifier).reset();
                }
              },
              child: SearchInput(
                searchType: SearchType.filter,
                onChanged: (String value) {
                  ref.read(filterResultsProvider.notifier).setQuery(
                        value.trim(),
                      );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
      flexibleSpace: Stack(
        children: <Widget>[
          Positioned.fill(
            child: GestureDetector(
              child: Container(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                color: Colors.transparent,
                child: const Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(''),
                    ),
                  ],
                ),
              ),
              onTap: () {
                PrimaryScrollController.of(context).animateTo(
                  0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeIn,
                );
              },
            ),
          ),
        ],
      ),
      actions: [
        Builder(
          builder: (context) {
            if (searchState.isOpen) {
              return const SizedBox.shrink();
            }

            return FilledButton.icon(
              onPressed: () => showWaitlistSorting(context),
              icon: waitlistSortingDirection == WaitlistSortingDirection.desc
                  ? const Icon(Icons.arrow_upward_rounded)
                  : const Icon(Icons.arrow_downward_rounded),
              label: Text(
                waitlistSortingStrings[waitlistSorting]?['title'] ??
                    waitlistSortingStrings[WaitlistSorting.date_added]![
                        'title']!,
                style: context.textStyles.labelLarge.copyWith(
                  color: context.colors.scheme.onPrimary,
                ),
              ),
            );
          },
        ),
        Builder(
          builder: (context) {
            if (searchState.isOpen) {
              return const SizedBox.shrink();
            }

            return Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  ref.read(filterResultsProvider.notifier).setIsOpen();
                },
                icon: const Icon(Icons.search),
              ),
            );
          },
        ),
        Builder(
          builder: (context) {
            if (searchState.isOpen) {
              return const SizedBox.shrink();
            }

            return const SettingsButton();
          },
        ),
      ],
    );
  }
}
