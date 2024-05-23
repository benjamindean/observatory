import 'package:flutter/material.dart';
import 'package:observatory/shared/context_extension.dart';

class ObservatoryBackButton extends StatelessWidget {
  const ObservatoryBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BackButton(
      style: IconButton.styleFrom(
        backgroundColor: context.highElevatedCanvasColor,
      ),
    );
  }
}
