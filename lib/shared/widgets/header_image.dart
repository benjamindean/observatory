import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:observatory/shared/widgets/image_error.dart';
import 'package:observatory/shared/widgets/progress_indicator.dart';

class HeaderImage extends StatelessWidget {
  final String? url;
  final bool isCompact;

  const HeaderImage({
    super.key,
    this.url,
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
        placeholder: (context, url) => const Opacity(
          opacity: 0.3,
          child: ObservatoryProgressIndicator(
            size: 30,
          ),
        ),
        errorWidget: (context, url, error) => ImageError(isCompact: isCompact),
        errorListener: (value) => true,
      );
    } catch (_) {
      return ImageError(isCompact: isCompact);
    }
  }
}
