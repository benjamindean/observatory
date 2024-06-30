import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/deal/ui/page_sections/deal_page_section_async.dart';
import 'package:observatory/deal/ui/page_sections/links_bottom_sheet.dart';
import 'package:observatory/shared/models/deal.dart';

class LinksTile extends StatelessWidget {
  final Deal deal;

  const LinksTile({
    super.key,
    required this.deal,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showLinksBottomSheet(context, deal),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: DealPageSectionAsync(
              state: const AsyncValue.data(true),
              deal: deal,
              onData: (_) {
                return Text(
                  'Steam, Metacritic, YouTube, etc.',
                  style: context.themes.text.labelLarge?.copyWith(
                    color: context.colors.scheme.onSurface,
                  ),
                );
              },
              heading: 'Links',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Icon(
              Icons.keyboard_arrow_up_rounded,
              color: context.colors.scheme.onSurfaceVariant,
            ),
          )
        ],
      ),
    );
  }
}
