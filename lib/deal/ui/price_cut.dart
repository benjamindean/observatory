import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:observatory/shared/context_extension.dart';

class PriceCut extends StatelessWidget {
  final num priceCut;

  const PriceCut({
    super.key,
    this.priceCut = 0,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle? textStyle = context.themes.text.titleLarge?.copyWith(
      fontSize: 22.0,
    );
    final int priceCutInt = priceCut.toInt();

    if (priceCutInt < 0) {
      return Icon(
        Icons.do_not_disturb_on_rounded,
        color: context.colors.disabled,
        size: textStyle?.fontSize,
      );
    }

    if (priceCutInt == 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '0',
            style: textStyle?.copyWith(
              color: context.colors.disabled,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3.0),
            child: Icon(
              Icons.percent,
              color: context.colors.disabled,
              size: 24,
            ),
          ),
        ],
      );
    }

    if (priceCutInt == 100) {
      return Icon(
        Icons.card_giftcard_rounded,
        color: context.colors.scheme.tertiary,
        size: textStyle?.fontSize,
      );
    }

    final Color highlightColor = context.colors.scheme.primary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: 6.0,
          height: 1.8,
          margin: const EdgeInsets.only(top: 3.0),
          color: highlightColor,
        ),
        SizedBox(width: 2.0),
        Text(
          priceCutInt.toString(),
          style: textStyle?.copyWith(
            color: highlightColor,
            fontFamily: context.semiBoldFont,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 3.0),
          child: Icon(
            Icons.percent,
            color: highlightColor,
            size: 24,
          ),
        ),
      ],
    );
  }
}
