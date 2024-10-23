import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:observatory/deal/providers/overview_provider.dart';
import 'package:observatory/deal/ui/page_sections/deal_page_section_async.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/models/overview.dart';
import 'package:observatory/shared/models/price.dart';
import 'package:observatory/shared/ui/dot_separator.dart';

class LowestPriceTile extends ConsumerWidget {
  final Deal deal;

  const LowestPriceTile({
    super.key,
    required this.deal,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Overview?> overviewState = ref.watch(
      overviewProvider(deal.id),
    );

    return DealPageSectionAsync<Overview?>(
      state: overviewState,
      deal: deal,
      heading: 'Lowest Price',
      onData: (data) {
        final Price? lowestPrice = data?.prices?.firstOrNull?.lowest;

        if (lowestPrice == null) {
          return Text(
            key: const Key('no-record'),
            'No record.',
            style: context.themes.text.labelLarge?.copyWith(
              color: context.colors.disabled,
            ),
          );
        }

        final String price = lowestPrice.price.formattedPrice;
        final String formattedDate = DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY)
            .format(DateTime.parse(lowestPrice.timestamp).toLocal())
            .toString();

        return Text.rich(
          TextSpan(
            style: context.themes.text.labelLarge?.copyWith(
              color: context.colors.scheme.onSurface,
            ),
            children: <TextSpan>[
              TextSpan(
                text: price,
              ),
              DotSeparator.textSpan(context),
              TextSpan(
                text: '${lowestPrice.cut.toInt()}%',
              ),
              DotSeparator.textSpan(context),
              TextSpan(
                text: lowestPrice.shop.name,
              ),
              DotSeparator.textSpan(context),
              TextSpan(
                text: formattedDate,
              ),
            ],
          ),
        );
      },
    );
  }
}
