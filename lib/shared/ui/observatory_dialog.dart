import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';

class ObservatoryDialog extends StatelessWidget {
  final void Function() onApply;
  final void Function() onDiscard;
  final String title;
  final String body;
  final String discardText;
  final String applyText;

  const ObservatoryDialog({
    super.key,
    required this.onApply,
    required this.onDiscard,
    required this.title,
    required this.body,
    this.discardText = 'Discard',
    this.applyText = 'Apply',
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        TextButton(
          onPressed: onDiscard,
          child: Text(
            discardText,
            style: TextStyle(
              color: context.colors.scheme.tertiary,
            ),
          ),
        ),
        TextButton(
          onPressed: onApply,
          child: Text(
            applyText,
            style: TextStyle(
              color: context.colors.scheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
