import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:observatory/shared/context_extension.dart';

class BottomSheetHeading extends StatelessWidget {
  final String text;
  final Widget? trailing;

  const BottomSheetHeading({
    super.key,
    required this.text,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16.0, right: 8.0),
      key: Key('bottom-sheet-heading-$text'),
      visualDensity: VisualDensity.compact,
      tileColor: context.midElevatedCanvasColor,
      title: Text(
        text,
        style: context.textStyles.labelLarge.copyWith(
          color: context.colors.scheme.onSurfaceVariant,
        ),
      ),
      trailing: trailing,
    );
  }
}
