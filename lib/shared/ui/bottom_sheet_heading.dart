import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:observatory/shared/context_extension.dart';

class BottomSheetHeading extends StatelessWidget {
  final String text;

  const BottomSheetHeading({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity.compact,
      tileColor: context.highElevatedCanvasColor,
      title: Text(
        text,
        style: context.textStyles.labelLarge.copyWith(
          color: context.colors.scheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
