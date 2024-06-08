import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/deal/combined_details_provider.dart';
import 'package:observatory/deal/ui/page_sections/deal_page_section_async.dart';
import 'package:observatory/shared/models/combined_details.dart';
import 'package:observatory/shared/models/deal.dart';

class SummaryTile extends ConsumerWidget {
  final Deal deal;

  const SummaryTile({
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
      heading: 'Summary',
      onData: (data) {
        final String summary = data.igdb?.summary ?? '';

        if (summary.isEmpty) {
          return Text(
            key: const Key('no-summary'),
            'No summary available.',
            style: context.themes.text.labelLarge?.copyWith(
              color: context.colors.disabled,
            ),
          );
        }

        return Text(
          summary,
          key: Key('summary-tile-${deal.id}'),
          style: context.themes.text.labelLarge?.copyWith(
            color: context.colors.scheme.onSurface,
          ),
        );
      },
    );
  }
}