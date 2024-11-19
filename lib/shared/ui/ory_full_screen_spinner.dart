import 'package:flutter/material.dart';
import 'package:observatory/shared/widgets/progress_indicator.dart';

class OryFullScreenSpinner extends StatelessWidget {
  final Widget? message;

  const OryFullScreenSpinner({
    super.key,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ObservatoryProgressIndicator(),
            if (message != null) message!,
          ],
        ),
      ),
    );
  }
}
