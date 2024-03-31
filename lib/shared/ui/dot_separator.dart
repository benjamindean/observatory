import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';

class DotSeparator extends StatelessWidget {
  const DotSeparator({super.key});

  static TextSpan textSpan(BuildContext context) {
    return TextSpan(
      style: context.textStyles.labelLarge.copyWith(
        color: context.colors.disabled,
      ),
      text: ' • ',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      ' • ',
      textAlign: TextAlign.justify,
      style: context.textStyles.titleLarge.copyWith(
        color: context.colors.disabled,
      ),
    );
  }
}
