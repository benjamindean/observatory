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
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: const EdgeInsets.all(12.0),
        backgroundColor: context.colors.scheme.inverseSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        behavior: SnackBarBehavior.floating,
        action: onAction != null
            ? SnackBarAction(
                textColor: context.colors.scheme.inversePrimary,
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
                  color: context.colors.scheme.onInverseSurface,
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
