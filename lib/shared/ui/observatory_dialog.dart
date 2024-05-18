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
      actionsPadding: const EdgeInsets.fromLTRB(
        16.0,
        8.0,
        16.0,
        8.0,
      ),
      title: Text(
        title,
        style: context.textStyles.titleLarge.copyWith(
          color: context.colors.scheme.onSurface,
        ),
      ),
      content: Text(
        body,
        style: context.textStyles.bodyMedium.copyWith(
          color: context.colors.scheme.onSurface,
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onDiscard,
          child: Text(
            discardText,
            style: TextStyle(
              color: context.colors.scheme.tertiary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextButton(
          onPressed: onApply,
          child: Text(
            applyText,
            style: TextStyle(
              color: context.colors.scheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
