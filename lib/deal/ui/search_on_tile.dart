import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchOnTile extends ConsumerWidget {
  final Deal deal;
  final String title;
  final Uri link;
  final IconData? leading;

  const SearchOnTile({
    super.key,
    required this.deal,
    required this.title,
    required this.link,
    this.leading,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      onTap: () {
        launchUrl(
          link,
          mode: LaunchMode.externalApplication,
        );
      },
      minLeadingWidth: 30,
      dense: true,
      leading: SizedBox(
        width: 30,
        child: Center(
          child: FaIcon(
            leading,
            size: context.themes.text.titleLarge?.fontSize,
          ),
        ),
      ),
      title: Row(
        children: [
          Text(
            title,
            style: context.themes.text.labelLarge?.copyWith(
              color: context.colors.scheme.onBackground,
            ),
          ),
        ],
      ),
    );
  }
}
