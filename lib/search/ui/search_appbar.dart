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

    if (searchState.isOpen) {
      return SliverAppBar(
        pinned: searchState.deals?.isEmpty ?? true ? true : false,
        floating: true,
        titleSpacing: 0.0,
        title: SearchInput(
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
        ),
      );
    }

    return SliverAppBar(
      pinned: searchState.deals?.isEmpty ?? true ? true : false,
      floating: true,
      actions: <Widget>[
        FilledButton.icon(
          style: FilledButton.styleFrom(
            side: BorderSide.none,
            visualDensity: VisualDensity.compact,
          ),
          onPressed: () {
            ref.read(searchResultsProvider.notifier).setIsOpen();
          },
          icon: const Icon(
            Icons.search,
            size: 16.0,
          ),
          label: const Text('Search'),
        ),
        const SettingsButton(),
      ],
    );
  }
}
