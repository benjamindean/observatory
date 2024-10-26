import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/search/providers/search_provider.dart';
import 'package:observatory/search/state/search_state.dart';
import 'package:observatory/shared/widgets/progress_indicator.dart';

class SearchInput extends ConsumerWidget {
  final SearchType searchType;
  final Function(String)? onSubmitted;
  final Function(String) onChanged;

  const SearchInput({
    super.key,
    this.searchType = SearchType.search,
    this.onSubmitted,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = searchType == SearchType.search
        ? dealSearchProvider
        : waitlistSearchProvider;

    final SearchState searchState = ref.watch(provider);

    return TextField(
      focusNode: searchState.focusNode,
      controller: searchState.searchInputController,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        hintText: 'Search',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        prefixIcon: Tooltip(
          message: 'Go Back',
          child: IconButton(
            icon: const Icon(Icons.arrow_back_outlined),
            onPressed: () {
              ref.read(provider.notifier).reset();
            },
          ),
        ),
        suffixIcon: Builder(
          builder: (context) {
            if (searchState.isLoading) {
              return const ObservatoryIconProgressIndicator();
            }

            return Tooltip(
              message: 'Reset Search',
              child: IconButton(
                onPressed: () {
                  if ((searchState.query ?? '').isEmpty) {
                    return ref.read(provider.notifier).reset();
                  }

                  return ref.read(provider.notifier).clear();
                },
                icon: const Icon(Icons.clear_outlined),
              ),
            );
          },
        ),
      ),
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }
}
