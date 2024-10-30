import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';

class Hint extends StatelessWidget {
  const Hint({
    super.key,
    required this.child,
    required this.icon,
  });

  final Widget child;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: context.colors.scheme.secondary,
          size: context.textStyles.labelMedium.fontSize,
        ),
        const SizedBox(width: 4.0),
        child,
      ],
    );
  }
}
