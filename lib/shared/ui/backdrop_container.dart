import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';

class BackdropContainer extends StatelessWidget {
  final Widget child;

  const BackdropContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.scheme.surface,
      child: child,
    );
  }
}
