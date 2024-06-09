import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PriceCut extends StatelessWidget {
  final num priceCut;

  const PriceCut({
    super.key,
    this.priceCut = 0,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle? textStyle = context.themes.text.titleLarge?.copyWith(
      fontSize: 20.0,
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
            padding: const EdgeInsets.only(top: 1.0),
            child: Icon(
              Icons.percent,
              color: context.colors.disabled,
              size: 22,
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
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 2.0, 2.0, 0),
          child: Container(
            width: 6.0,
            height: 1.8,
            color: highlightColor,
          ),
        ),
        Text(
          priceCutInt.toString(),
          style: textStyle?.copyWith(
            color: highlightColor,
            fontFamily: GoogleFonts.openSans(
              fontWeight: FontWeight.w500,
            ).fontFamily,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 1.0),
          child: Icon(
            Icons.percent,
            color: highlightColor,
            size: 22,
          ),
        ),
      ],
    );
  }
}
