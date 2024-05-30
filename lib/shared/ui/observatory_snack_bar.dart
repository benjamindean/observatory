import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';

class ObservatorySnackBar {
  final Widget content;
  final void Function()? onAction;
  final Icon? icon;

  const ObservatorySnackBar({
    this.onAction,
    this.icon,
    required this.content,
  });

  static void show(
    BuildContext context, {
    void Function()? onAction,
    IconData? icon,
    required Widget content,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        margin: const EdgeInsets.all(12.0),
        backgroundColor: context.colors.scheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior: SnackBarBehavior.floating,
        action: onAction != null
            ? SnackBarAction(
                textColor: context.colors.scheme.onPrimary,
                label: 'Undo',
                onPressed: onAction,
              )
            : null,
        content: Row(
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Icon(
                  icon,
                  color: context.themes.snackBar.contentTextStyle?.color,
                ),
              ),
            Expanded(
              child: content,
            )
          ],
        ),
        clipBehavior: Clip.antiAlias,
      ),
    );
  }
}
