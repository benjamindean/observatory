import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:observatory/deal/combined_details_provider.dart';
import 'package:observatory/deal/ui/page_sections/deal_page_section_async.dart';
import 'package:observatory/shared/models/combined_details.dart';
import 'package:observatory/shared/models/deal.dart';

class ReleaseDateTile extends ConsumerWidget {
  final Deal deal;

  const ReleaseDateTile({
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
      heading: 'Release Date',
      onData: (data) {
        final int? date = data.igdb?.first_release_date;

        if (date == null) {
          return Text(
            key: const Key('no-release-date'),
            'No release date available.',
            style: context.themes.text.labelLarge?.copyWith(
              color: context.colors.disabled,
            ),
          );
        }

        return Text(
          DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY)
              .format(
                  DateTime.fromMillisecondsSinceEpoch(date * 1000).toLocal())
              .toString(),
          key: Key('release-date-tile-${deal.id}'),
          style: context.themes.text.labelLarge?.copyWith(
            color: context.colors.scheme.onSurface,
          ),
        );
      },
    );
  }
}
