import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:observatory/shared/widgets/image_error.dart';

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
        fadeInDuration: const Duration(milliseconds: 200),
        fadeOutDuration: const Duration(milliseconds: 200),
        imageUrl: url ?? '',
        placeholder: (context, url) => ImageError(isCompact: isCompact),
        errorWidget: (context, url, error) => ImageError(isCompact: isCompact),
        errorListener: (value) => true,
      );
    } catch (_) {
      return ImageError(isCompact: isCompact);
    }
  }
}
