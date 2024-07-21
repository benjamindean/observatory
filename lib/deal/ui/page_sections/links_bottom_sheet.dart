import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:observatory/deal/ui/page_sections/search_on_tile.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/ui/bottom_sheet_container.dart';
import 'package:observatory/shared/ui/bottom_sheet_heading.dart';
import 'package:observatory/shared/ui/backdrop_container.dart';

void showLinksBottomSheet(BuildContext context, Deal deal) {
  showModalBottomSheet(
    useRootNavigator: true,
    useSafeArea: true,
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return LinksBottomSheet(
        deal: deal,
      );
    },
  );
}

class LinksBottomSheet extends StatelessWidget {
  final Deal deal;

  const LinksBottomSheet({
    super.key,
    required this.deal,
  });

  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BottomSheetHeading(text: 'Links'),
            BackdropContainer(
              child: Column(
                children: [
                  Builder(
                    builder: (context) {
                      final Uri? uri = Uri.tryParse(deal.steamPrice?.url ?? '');

                      return SearchOnTile(
                        deal: deal,
                        title: 'Steam',
                        leading: FontAwesomeIcons.steam,
                        link: (uri != null && uri.toString().isNotEmpty)
                            ? uri
                            : Uri.parse(
                                'https://store.steampowered.com/search/?term=${Uri.encodeQueryComponent(deal.title)}',
                              ),
                      );
                    },
                  ),
                  SearchOnTile(
                    deal: deal,
                    title: 'YouTube',
                    leading: FontAwesomeIcons.youtube,
                    link: Uri.parse(
                      'https://www.youtube.com/results?search_query=${Uri.encodeQueryComponent(deal.title)}',
                    ),
                  ),
                  SearchOnTile(
                    deal: deal,
                    title: 'Wikipedia',
                    leading: FontAwesomeIcons.wikipediaW,
                    link: Uri.parse(
                      'https://en.wikipedia.org/w/index.php?search=${Uri.encodeComponent(deal.title)}',
                    ),
                  ),
                  SearchOnTile(
                    deal: deal,
                    title: 'Metacritic',
                    leading: FontAwesomeIcons.squareArrowUpRight,
                    link: Uri.parse(
                      'https://www.metacritic.com/search/${Uri.encodeComponent(deal.title)}/',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
