import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';

class ObservatoryShimmer extends StatelessWidget {
  const ObservatoryShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      backgroundColor: context.colors.scheme.surface,
      minHeight: 4,
      color: context.colors.scheme.onSurfaceVariant.withValues(alpha: 0.2),
    );
  }
}
