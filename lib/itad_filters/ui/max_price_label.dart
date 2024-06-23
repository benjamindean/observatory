import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:observatory/shared/helpers/currency_setter.dart';

class MaxPriceLabel extends StatelessWidget {
  final int? maxPrice;

  const MaxPriceLabel({
    super.key,
    this.maxPrice,
  });

  @override
  Widget build(BuildContext context) {
    if (maxPrice == null) {
      return Text(
        'Any',
        style: context.textStyles.titleMedium.copyWith(
          color: context.colors.scheme.onSurface,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    final String currency = GetIt.I<Currency>().name;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 1.0),
          child: Icon(
            Icons.keyboard_arrow_left_rounded,
            size: 24,
          ),
        ),
        Text(
          NumberFormat.simpleCurrency(
            name: currency,
            decimalDigits: 0,
          ).format(maxPrice),
          style: context.textStyles.titleMedium.copyWith(
            color: context.colors.scheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
