import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:observatory/shared/ui/constants.dart';

class ObservatoryCard extends StatelessWidget {
  final Widget child;

  const ObservatoryCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colors.scheme.surface,
      surfaceTintColor: context.colors.scheme.surfaceTint,
      elevation: CARD_ELEVATION,
      child: child,
    );
  }
}
