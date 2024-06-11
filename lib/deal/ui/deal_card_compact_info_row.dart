import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:observatory/deal/ui/current_price.dart';
import 'package:observatory/deal/ui/price_cut.dart';
import 'package:observatory/shared/context_extension.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/models/price.dart';
import 'package:observatory/shared/ui/dot_separator.dart';

class DealCardCompactInfoRow extends StatelessWidget {
  const DealCardCompactInfoRow({
    super.key,
    required this.deal,
  });

  final Deal deal;

  @override
  Widget build(BuildContext context) {
    final Price? price = deal.prices?.firstOrNull;

    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            deal.titleParsed,
            maxLines: 2,
            style: context.themes.text.titleSmall?.copyWith(
              color: context.colors.scheme.onSurface,
              fontFamily: context.semiBoldFont,
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
          ),
          Builder(
            builder: (context) {
              if (price == null) {
                return Text(
                  'No prices available.',
                  style: context.themes.text.labelMedium?.copyWith(
                    color: context.colors.disabled,
                  ),
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  PriceCut(
                    priceCut: price.cut,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 2.0),
                    child: DotSeparator(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 3.5),
                    child: CurrentPrice(price: price),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
