import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/widgets/progress_indicator.dart';

class HeaderImage extends StatelessWidget {
  final String id;
  final String? url;
  final bool isCompact;

  const HeaderImage({
    super.key,
    this.url,
    required this.id,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    if (url == null) {
      return ImageError(isCompact: isCompact);
    }

    try {
      return CachedNetworkImage(
        fit: BoxFit.cover,
        fadeInDuration: const Duration(milliseconds: 100),
        imageUrl: url ?? '',
        placeholder: (context, url) =>
            const ObservatoryProgressIndicator(size: 30),
        errorWidget: (context, url, error) => ImageError(isCompact: isCompact),
      );
    } catch (_) {
      return ImageError(isCompact: isCompact);
    }
  }
}

class ImageError extends StatelessWidget {
  final bool isCompact;

  const ImageError({
    super.key,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.scheme.onInverseSurface,
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
