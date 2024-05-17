import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:observatory/deal/ui/search_on_tile.dart';
import 'package:observatory/shared/models/deal.dart';

class LinksTile extends StatelessWidget {
  const LinksTile({
    super.key,
    required this.deal,
  });

  final Deal deal;

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      dense: true,
      child: ExpansionTile(
        title: Text(
          'Links',
          style: context.themes.text.labelLarge?.copyWith(
            color: context.colors.hint,
          ),
        ),
        subtitle: Text(
          'Steam, Metacritic, YouTube, etc.',
          style: context.themes.text.labelLarge?.copyWith(
            color: context.colors.scheme.onSurface,
          ),
        ),
        children: [
          Builder(
            builder: (context) {
              if (deal.steamPrice != null) {
                return SearchOnTile(
                  deal: deal,
                  title: 'Open on Steam',
                  leading: FontAwesomeIcons.steam,
                  link: Uri.parse(deal.steamPrice!.url),
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
    );
  }
}
