import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:observatory/shared/context_extension.dart';

class ObservatoryBackButton extends StatelessWidget {
  const ObservatoryBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BackButton(
      color: context.colors.scheme.onSurfaceVariant,
      key: const Key('observatory-back-button'),
      style: IconButton.styleFrom(
        backgroundColor: context.highElevatedCanvasColor,
      ),
    );
  }
}
