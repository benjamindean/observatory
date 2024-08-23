import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:observatory/deal/ui/price_row.dart';
import 'package:observatory/shared/context_extension.dart';
import 'package:observatory/shared/models/deal.dart';

class DealCardInfoRow extends StatelessWidget {
  const DealCardInfoRow({
    super.key,
    required this.deal,
  });

  final Deal deal;

  @override
  Widget build(BuildContext context) {
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
          PriceRow(
            price: deal.prices?.firstOrNull,
          ),
        ],
      ),
    );
  }
}
