import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/deal/providers/game_details_provider.dart';
import 'package:observatory/deal/ui/page_sections/deal_page_section_async.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/models/igdb/igdb_game.dart';
import 'package:observatory/shared/ui/constants.dart';

class SupportedPlatformsTile extends ConsumerWidget {
  final Deal deal;

  const SupportedPlatformsTile({
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
      heading: 'Platforms',
      onData: (data) {
        final List<IGDBPlatform> platforms = data?.platforms ?? [];

        if (platforms.isEmpty) {
          return Text(
            key: const Key('no-platforms'),
            'No information available.',
            style: context.themes.text.labelLarge?.copyWith(
              color: context.colors.disabled,
            ),
          );
        }

        return Wrap(
          children: List<Widget>.generate(
            platforms.length,
            (int idx) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Chip(
                  surfaceTintColor: context.colors.scheme.surfaceTint,
                  elevation: CARD_ELEVATION,
                  label: Text(
                    platforms[idx].abbreviation.toString(),
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
