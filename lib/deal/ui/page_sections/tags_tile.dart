import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/deal/combined_details_provider.dart';
import 'package:observatory/deal/ui/page_sections/deal_page_section_async.dart';
import 'package:observatory/shared/context_extension.dart';
import 'package:observatory/shared/models/combined_details.dart';
import 'package:observatory/shared/models/deal.dart';

class TagsTile extends ConsumerWidget {
  final Deal deal;

  const TagsTile({
    super.key,
    required this.deal,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<CombinedDetails> infoState = ref.watch(
      combinedDetailsProvider(deal),
    );

    return DealPageSectionAsync<CombinedDetails>(
      state: infoState,
      deal: deal,
      heading: 'Tags',
      onData: (info) {
        final List<String> itadTags = info.itad?.tags ?? [];
        final List<String> igdbThemes =
            info.igdb?.themes.map((e) => e.name).nonNulls.toList() ?? [];

        final List<String> tags = Set<String>.from(
          List<String>.from(itadTags)..addAll(igdbThemes),
        ).toList();

        if (tags.isEmpty) {
          return Text(
            key: const Key('no-tags-available'),
            'No tags available.',
            style: context.themes.text.labelLarge?.copyWith(
              color: context.colors.disabled,
            ),
          );
        }

        return Wrap(
          key: Key('tags-tile-${deal.id}'),
          children: List<Widget>.generate(
            tags.length,
            (int idx) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Chip(
                  label: Text(
                    tags[idx],
                    textScaler: const TextScaler.linear(0.9),
                    style: context.themes.text.labelLarge?.copyWith(
                      color: context.colors.scheme.onSurface,
                    ),
                  ),
                  backgroundColor: context.elevatedCanvasColor,
                  padding: const EdgeInsets.all(6.0),
                  visualDensity: VisualDensity.compact,
                  side: BorderSide.none,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
