import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:observatory/deal/overview_provider.dart';
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
    final AsyncValue<Overview?> overviewPod = ref.watch(
      overviewProvider(deal.id),
    );

    return ListTile(
      dense: true,
      title: Text(
        'Lowest Price',
        style: context.themes.text.labelLarge?.copyWith(
          color: context.colors.hint,
        ),
      ),
      subtitle: AnimatedSwitcher(
        layoutBuilder: (
          Widget? currentChild,
          List<Widget> previousChildren,
        ) {
          return Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              ...previousChildren,
              if (currentChild != null) currentChild,
            ],
          );
        },
        duration: const Duration(milliseconds: 200),
        child: overviewPod.when(
          data: (data) {
            final Price? lowestPrice = data?.prices?.firstOrNull?.lowest;

            if (lowestPrice == null) {
              return Text(
                'No record.',
                style: context.themes.text.labelLarge?.copyWith(
                  color: context.colors.disabled,
                ),
              );
            }

            final String price = lowestPrice.price.formattedPrice;
            final String formattedDate =
                DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY)
                    .format(DateTime.parse(lowestPrice.timestamp).toLocal())
                    .toString();

            return RichText(
              text: TextSpan(
                style: context.themes.text.labelLarge?.copyWith(
                  color: context.colors.scheme.onBackground,
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
          loading: () => LinearProgressIndicator(
            borderRadius: BorderRadius.circular(12.0),
            minHeight: 2,
            color: context.colors.scheme.onSurfaceVariant,
          ),
          error: (error, stackTrace) {
            Logger().e(
              'Failed to load overview',
              error: error,
              stackTrace: stackTrace,
            );

            FirebaseCrashlytics.instance.recordError(
              error,
              stackTrace,
            );

            return Text(
              'Unknown',
              style: context.themes.text.labelLarge?.copyWith(
                color: context.colors.disabled,
              ),
            );
          },
        ),
      ),
    );
  }
}
