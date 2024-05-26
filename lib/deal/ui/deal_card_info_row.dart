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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 25,
          child: Column(
            children: [
              PriceCut(
                priceCut: deal.prices?.firstOrNull?.cut ?? -1,
              )
            ],
          ),
        ),
        Expanded(
          flex: 56,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            minVerticalPadding: 16.0,
            title: Text(
              deal.titleParsed,
              maxLines: 2,
              style: context.themes.text.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colors.scheme.onSurface,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: PriceNew(prices: deal.prices),
          ),
        ),
        Expanded(
          flex: 20,
          child: Column(
            children: [
              WaitlistButton(deal: deal),
            ],
          ),
        )
      ],
    );
  }
}
