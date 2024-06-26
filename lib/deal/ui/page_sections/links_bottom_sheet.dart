import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:observatory/deal/ui/page_sections/search_on_tile.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/ui/bottom_sheet_heading.dart';

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
    return ColoredBox(
      color: context.colors.scheme.surface,
      child: SafeArea(
        child: ColoredBox(
          color: context.colors.scheme.surfaceContainer,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BottomSheetHeading(text: 'Links'),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: context.colors.scheme.surface,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    children: [
                      Builder(
                        builder: (context) {
                          final Uri? uri =
                              Uri.tryParse(deal.steamPrice?.url ?? '');

                          if (uri != null && uri.toString().isNotEmpty) {
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
