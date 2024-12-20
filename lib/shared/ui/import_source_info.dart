import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/waitlist/providers/waitlist_provider.dart';

final Map<DealSource, String> dealSourceNames = {
  DealSource.itad: 'IsThereAnyDeal',
  DealSource.steam: 'Steam',
  DealSource.observatory: 'Observatory',
};

class ImportSourceInfo extends ConsumerWidget {
  final Deal deal;

  const ImportSourceInfo({
    super.key,
    required this.deal,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> waitlist = ref.watch(waitlistIdsProvider);
    final bool isInWaitlist = waitlist.contains(deal.id);

    if (!isInWaitlist) {
      return const SizedBox.shrink();
    }

    return Padding(
      key: const Key('import_source_info'),
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
      child: Text.rich(
        TextSpan(
          style: context.themes.text.labelMedium?.copyWith(
            color: context.colors.disabled,
          ),
          children: [
            const TextSpan(
              text: 'Added from ',
            ),
            TextSpan(
              text: dealSourceNames[deal.source] ?? 'Unknown',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const TextSpan(
              text: ' on ',
            ),
            TextSpan(
              text: DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(
                DateTime.fromMillisecondsSinceEpoch(
                  deal.added.toInt(),
                ),
              ),
              style: context.themes.text.labelSmall?.copyWith(
                color: context.colors.disabled,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
