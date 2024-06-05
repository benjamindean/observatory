import 'package:flutter/material.dart';
import 'package:observatory/shared/context_extension.dart';

class ObservatoryBackButton extends StatelessWidget {
  const ObservatoryBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BackButton(
      key: const Key('observatory-back-button'),
      style: IconButton.styleFrom(
        backgroundColor: context.highElevatedCanvasColor,
      ),
    );
  }
}
