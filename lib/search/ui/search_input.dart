import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/search/search_provider.dart';
import 'package:observatory/search/search_state.dart';

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
        ? searchResultsProvider
        : filterResultsProvider;

    final SearchState searchState = ref.watch(provider);

    return TextField(
      focusNode: searchState.focusNode,
      controller: searchState.searchInputController,
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        hintText: 'Search',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(30),
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
              return Transform.scale(
                scale: 0.4,
                child: const CircularProgressIndicator(),
              );
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
