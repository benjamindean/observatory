import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';

class DotSeparator extends StatelessWidget {
  const DotSeparator({
    super.key,
  });

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
    return Padding(
      key: const Key('dot-separator'),
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.colors.disabled,
            shape: BoxShape.circle,
          ),
          child: const SizedBox(
            width: 4.2,
            height: 4.2,
          )),
    );
  }
}
