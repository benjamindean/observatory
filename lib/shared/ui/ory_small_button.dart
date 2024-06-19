import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';

class OrySmallButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData icon;
  final String label;
  final Color? buttonColor;
  final Color? textColor;

  const OrySmallButton({
    super.key,
    this.onPressed,
    this.textColor,
    this.buttonColor,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 16.0, 8.0),
        visualDensity: VisualDensity.compact,
        backgroundColor: buttonColor ?? context.colors.scheme.primary,
      ),
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: textColor ?? context.colors.scheme.onPrimary,
        size: 16.0,
      ),
      label: Text(
        label,
        style: context.textStyles.labelLarge.copyWith(
          color: textColor ?? context.colors.scheme.onPrimary,
        ),
      ),
    );
  }
}
