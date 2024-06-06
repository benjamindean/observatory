import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:observatory/deal/ui/page_sections/search_on_tile.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/ui/bottom_sheet_heading.dart';

void showLinksList(BuildContext context, Deal deal) {
  showModalBottomSheet(
    useRootNavigator: true,
    useSafeArea: true,
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return LinksList(
        deal: deal,
      );
    },
  );
}

class LinksList extends StatelessWidget {
  final Deal deal;

  const LinksList({
    super.key,
    required this.deal,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BottomSheetHeading(text: 'Links'),
            Builder(
              builder: (context) {
                final Uri? uri = Uri.tryParse(deal.steamPrice?.url ?? '');

                if (uri != null) {
                  return SearchOnTile(
                    deal: deal,
                    title: 'Open on Steam',
                    leading: FontAwesomeIcons.steam,
                    link: uri,
                  );
                }

                return SearchOnTile(
                  deal: deal,
                  title: 'Search on Steam',
                  leading: FontAwesomeIcons.steam,
                  link: Uri.parse(
                    'https://store.steampowered.com/search/?term=${Uri.encodeQueryComponent(deal.title)}',
                  ),
                );
              },
            ),
            SearchOnTile(
              deal: deal,
              title: 'Search on YouTube',
              leading: FontAwesomeIcons.youtube,
              link: Uri.parse(
                'https://www.youtube.com/results?search_query=${Uri.encodeQueryComponent(deal.title)}',
              ),
            ),
            SearchOnTile(
              deal: deal,
              title: 'Search on Wikipedia',
              leading: FontAwesomeIcons.wikipediaW,
              link: Uri.parse(
                'https://en.wikipedia.org/w/index.php?search=${Uri.encodeComponent(deal.title)}',
              ),
            ),
            SearchOnTile(
              deal: deal,
              title: 'Search on Metacritic',
              leading: FontAwesomeIcons.squareArrowUpRight,
              link: Uri.parse(
                'https://www.metacritic.com/search/${Uri.encodeComponent(deal.title)}/',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
