import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';

class MinCutLabel extends StatelessWidget {
  final int? minCut;

  const MinCutLabel({
    super.key,
    this.minCut,
  });

  @override
  Widget build(BuildContext context) {
    if (minCut == null) {
      return Text(
        'Any',
        style: context.textStyles.titleMedium.copyWith(
          color: context.colors.scheme.onSurface,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          minCut.toString(),
          style: context.textStyles.titleMedium.copyWith(
            color: context.colors.scheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 1.0),
          child: Icon(
            Icons.percent,
            size: 20,
          ),
        ),
      ],
    );
  }
}
