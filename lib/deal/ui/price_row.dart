import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:observatory/deal/ui/current_price.dart';
import 'package:observatory/deal/ui/price_cut.dart';
import 'package:observatory/shared/models/price.dart';
import 'package:observatory/shared/ui/dot_separator.dart';

class PriceRow extends StatelessWidget {
  final Price? price;

  const PriceRow({
    super.key,
    this.price,
  });

  @override
  Widget build(BuildContext context) {
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
          priceCut: price!.cut,
        ),
        const Padding(
          padding: EdgeInsets.only(top: 2.0),
          child: DotSeparator(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 3.5),
          child: CurrentPrice(price: price!),
        ),
      ],
    );
  }
}
