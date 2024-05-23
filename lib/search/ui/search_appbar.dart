import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/search/search_provider.dart';
import 'package:observatory/search/search_state.dart';
import 'package:observatory/search/ui/search_input.dart';
import 'package:observatory/shared/widgets/settings_button.dart';

class SearchAppBar extends ConsumerWidget {
  const SearchAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SearchState searchState = ref.watch(searchResultsProvider);

    return SliverAppBar(
      pinned: searchState.deals?.isEmpty ?? true ? true : false,
      floating: true,
      titleSpacing: 0.0,
      title: Builder(
        builder: (context) {
          if (searchState.isOpen) {
            return SearchInput(
              searchType: SearchType.search,
              onChanged: (String value) {
                ref.read(searchResultsProvider.notifier).setQuery(value);
              },
              onSubmitted: (String value) {
                if (value.trim().isNotEmpty) {
                  ref.read(searchResultsProvider.notifier).performSearch(value);
                  ref.read(asynRecentsProvider.notifier).addRecent(value);
                }
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
      actions: <Widget>[
        Builder(
          builder: (context) {
            if (searchState.isOpen) {
              return const SizedBox.shrink();
            }

            return FilledButton.icon(
              onPressed: () {
                ref.read(searchResultsProvider.notifier).setIsOpen();
              },
              icon: const Icon(Icons.search),
              label: const Text('Search'),
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
        )
      ],
    );
  }
}
