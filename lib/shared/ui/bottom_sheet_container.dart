import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:observatory/shared/context_extension.dart';

class BottomSheetContainer extends StatelessWidget {
  final Widget child;
  final Color? color;

  const BottomSheetContainer({
    super.key,
    required this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.scheme.surface,
      child: SafeArea(
        child: ColoredBox(
          color: color ?? context.midElevatedCanvasColor,
          child: child,
        ),
      ),
    );
  }
}
