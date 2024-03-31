import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';

class PriceCut extends StatelessWidget {
  final num priceCut;

  const PriceCut({
    super.key,
    this.priceCut = 0,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle? textStyle = context.themes.text.titleLarge;
    final int priceCutInt = priceCut.toInt();

    if (priceCutInt < 0) {
      return Icon(
        Icons.do_not_disturb_on_rounded,
        color: context.colors.disabled,
        size: textStyle?.fontSize,
      );
    }

    if (priceCutInt == 0) {
      return Text(
        '0%',
        style: textStyle?.copyWith(
          fontWeight: FontWeight.bold,
          color: context.colors.disabled,
        ),
      );
    }

    if (priceCutInt == 100) {
      return Icon(
        Icons.card_giftcard_rounded,
        color: context.colors.scheme.secondary,
        size: textStyle?.fontSize,
      );
    }

    return Text(
      '$priceCutInt%',
      style: textStyle?.copyWith(
        fontWeight: FontWeight.bold,
        color: context.colors.scheme.primary
            .withGreen(160 - priceCutInt)
            .withBlue(160 - priceCutInt),
      ),
    );
  }
}
