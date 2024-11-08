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
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: context.textStyles.titleLarge.copyWith(
                color: context.colors.scheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Text(
              body,
              style: context.textStyles.bodyMedium.copyWith(
                color: context.colors.scheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32.0),
            OverflowBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: onDiscard,
                  child: Text(
                    discardText,
                    style: context.textStyles.labelLarge.copyWith(
                      color: context.colors.scheme.onErrorContainer,
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                FilledButton(
                  onPressed: onApply,
                  child: Text(
                    applyText,
                    style: context.textStyles.labelLarge.copyWith(
                      color: context.colors.scheme.onPrimary,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
