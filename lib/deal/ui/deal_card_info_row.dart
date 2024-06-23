import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:observatory/deal/ui/price_cut.dart';
import 'package:observatory/deal/ui/price_new.dart';
import 'package:observatory/deal/ui/waitlist_button.dart';
import 'package:observatory/shared/models/deal.dart';

class DealCardInfoRow extends StatelessWidget {
  const DealCardInfoRow({
    super.key,
    required this.deal,
  });

  final Deal deal;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 25,
          child: PriceCut(
            priceCut: deal.prices?.firstOrNull?.cut ?? -1,
          ),
        ),
        Expanded(
          flex: 56,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  deal.titleParsed,
                  maxLines: 2,
                  style: context.themes.text.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colors.scheme.onSurface,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                PriceNew(prices: deal.prices),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 20,
          child: WaitlistButton(deal: deal),
        ),
      ],
    );
  }
}
