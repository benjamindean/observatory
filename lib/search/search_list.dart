import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:observatory/deal/ui/deal_card.dart';
import 'package:observatory/search/providers/search_provider.dart';
import 'package:observatory/search/state/search_state.dart';
import 'package:observatory/search/ui/recent_searches_list.dart';
import 'package:observatory/settings/providers/settings_provider.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/ui/constants.dart';
import 'package:observatory/shared/ui/ory_full_screen_spinner.dart';
import 'package:observatory/shared/widgets/error_message.dart';

class SearchList extends ConsumerWidget {
  const SearchList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SearchState searchState = ref.watch(searchProvider(
      SearchType.search,
    ));
    final DealCardType cardType = ref.watch(
      asyncSettingsProvider.select(
        (value) => value.valueOrNull?.dealCardType ?? DealCardType.compact,
      ),
    );
    final bool showHeaders = ref.watch(
      asyncSettingsProvider.select(
        (value) => value.valueOrNull?.showHeaders ?? false,
      ),
    );
    final double? screenWidth = cardType == DealCardType.compact
        ? null
        : MediaQuery.of(context).size.width;
    final double height = cardHeight(showHeaders, cardType, screenWidth);

    return Builder(
      builder: (BuildContext context) {
        if (searchState.isLoading) {
          return const OryFullScreenSpinner();
        }

        if (searchState.deals == null) {
          return const RecentSearchesList();
        }

        final List<Deal> deals = searchState.deals ?? [];

        if (searchState.deals?.isEmpty == true) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: ErrorMessage(
              message: 'No results found for your query.',
              icon: FontAwesomeIcons.solidFaceSadTear,
            ),
          );
        }

        return SliverPadding(
          key: const Key('search-scroll-view'),
          padding: const EdgeInsets.all(6.0),
          sliver: SliverFixedExtentList.builder(
            itemExtent: height,
            itemCount: searchState.deals?.length ?? 0,
            itemBuilder: (context, index) {
              return DealCard(
                deal: deals[index],
                cardType: cardType,
              );
            },
          ),
        );
      },
    );
  }
}
