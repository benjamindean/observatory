import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/deal/providers/game_details_provider.dart';
import 'package:observatory/deal/ui/page_sections/deal_page_section_async.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/models/game/game.dart';

class SummaryTile extends ConsumerWidget {
  final Deal deal;

  const SummaryTile({
    super.key,
    required this.deal,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<GameDetails?> infoState = ref.watch(
      gameDetailsProvider(deal),
    );

    return DealPageSectionAsync<GameDetails?>(
      state: infoState,
      deal: deal,
      heading: 'Summary',
      onData: (data) {
        final String summary = data?.summary ?? '';

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
          style: context.themes.text.labelLarge?.copyWith(
            color: context.colors.scheme.onSurface,
          ),
        );
      },
    );
  }
}
