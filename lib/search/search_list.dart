import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/deal/ui/deal_card.dart';
import 'package:observatory/search/search_provider.dart';
import 'package:observatory/search/search_state.dart';
import 'package:observatory/search/ui/recent_searches_list.dart';
import 'package:observatory/shared/widgets/error_message.dart';
import 'package:observatory/shared/widgets/progress_indicator.dart';

class SearchList extends ConsumerWidget {
  const SearchList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SearchState searchState = ref.watch(searchProvider(
      SearchType.search,
    ));

    return Builder(
      builder: (BuildContext context) {
        if (searchState.isLoading) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: ObservatoryProgressIndicator(),
            ),
          );
        }

        if (searchState.deals == null) {
          return const RecentSearchesList();
        }

        if (searchState.deals != null && searchState.deals?.isEmpty == true) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: ErrorMessage(
                message: 'No results found for your query.',
                icon: Icons.sentiment_neutral_rounded,
              ),
            ),
          );
        }

        return SliverPadding(
          key: const Key('search_scroll_view'),
          padding: const EdgeInsets.all(6.0),
          sliver: SliverList.builder(
            itemCount: searchState.deals?.length ?? 0,
            itemBuilder: (context, index) {
              return DealCard(
                deal: searchState.deals![index],
              );
            },
          ),
        );
      },
    );
  }
}
