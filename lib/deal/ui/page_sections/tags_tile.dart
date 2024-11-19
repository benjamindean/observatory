import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/deal/providers/info_provider.dart';
import 'package:observatory/deal/ui/page_sections/deal_page_section_async.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/models/info.dart';

class TagsTile extends ConsumerWidget {
  final Deal deal;

  const TagsTile({
    super.key,
    required this.deal,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Info?> infoState = ref.watch(
      infoProvider(deal.id),
    );

    return DealPageSectionAsync<Info?>(
      state: infoState,
      deal: deal,
      heading: 'Tags',
      onData: (info) {
        final List<String> tags = info?.tags ?? [];

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
