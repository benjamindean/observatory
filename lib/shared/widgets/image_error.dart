import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:observatory/shared/constans.dart';

class ImageError extends StatelessWidget {
  final bool isCompact;

  const ImageError({
    super.key,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      key: const Key('image-error'),
      color: context.colors.scheme.surfaceContainerLow,
      child: OverflowBox(
        maxWidth: double.infinity,
        maxHeight: (isCompact ? IMAGE_HEIGHT / 2 : IMAGE_HEIGHT).toDouble(),
        child: AspectRatio(
          aspectRatio: IMAGE_WIDTH / IMAGE_HEIGHT,
          child: Icon(
            Icons.sports_esports_rounded,
            size: isCompact ? 255 / 4 : 255 / 2,
            color: context.colors.disabled,
          ),
        ),
      ),
    );
  }
}
