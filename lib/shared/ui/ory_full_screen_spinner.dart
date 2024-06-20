import 'package:flutter/material.dart';
import 'package:observatory/shared/widgets/progress_indicator.dart';

class OryFullScreenSpinner extends StatelessWidget {
  const OryFullScreenSpinner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: ObservatoryProgressIndicator(),
      ),
    );
  }
}
