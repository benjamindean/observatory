import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/deal/providers/game_details_provider.dart';
import 'package:observatory/deal/ui/page_sections/deal_page_section_async.dart';
import 'package:observatory/deal/ui/page_sections/screenshots/gallery_view.dart';
import 'package:observatory/shared/constans.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/models/game/game.dart';
import 'package:observatory/shared/widgets/image_error.dart';

void openGallery(
  BuildContext context,
  final Deal deal,
  final int index,
  final List<GameScreenshot> screenshots,
  final List<GameVideo> videos,
) {
  showDialog(
    useSafeArea: false,
    barrierDismissible: false,
    barrierColor: Colors.black87,
    context: context,
    builder: (context) {
      return GalleryView(
        deal: deal,
        index: index,
        screenshots: screenshots,
        videos: videos,
      );
    },
  );
}

class ScreenshotsTile extends ConsumerWidget {
  final Deal deal;

  const ScreenshotsTile({
    super.key,
    required this.deal,
  });

  String getURL(item) {
    if (item is GameVideo) {
      if (item.isYouTube) {
        return 'https://img.youtube.com/vi/${item.video_id}/hqdefault.jpg';
      }

      return '';
    }

    return item.getURL() ?? '';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<GameDetails?> infoState = ref.watch(
      gameDetailsProvider(Deal(id: deal.id, title: deal.title)),
    );

    return DealPageSectionAsync<GameDetails?>(
      state: infoState,
      deal: deal,
      heading: 'Screenshots',
      onData: (data) {
        final List<GameScreenshot> screenshots = data?.screenshots ?? [];
        final List<GameVideo> videos =
            (data?.videos ?? []).where((v) => v.isYouTube).toList();

        final List media = [...screenshots, ...videos];

        if (media.isEmpty) {
          return Text(
            key: const Key('no-screenshots'),
            'No screenshots available.',
            style: context.themes.text.labelLarge?.copyWith(
              color: context.colors.disabled,
            ),
          );
        }

        return SizedBox(
          height: SCREENSHOT_HEIGHT / THUMBNAIL_DELIMITER,
          child: ListView.builder(
            itemExtent: SCREENSHOT_WIDTH / THUMBNAIL_DELIMITER,
            itemCount: media.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final item = media[index];

              return GestureDetector(
                onTap: () => openGallery(
                  context,
                  deal,
                  index,
                  screenshots,
                  videos,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      color: context.colors.scheme.surface,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CachedNetworkImage(
                            fit: BoxFit.cover,
                            fadeInDuration: const Duration(milliseconds: 200),
                            fadeOutDuration: const Duration(milliseconds: 200),
                            imageUrl: getURL(item),
                            placeholder: (context, url) => const ImageError(
                              isCompact: true,
                            ),
                            errorWidget: (context, url, error) =>
                                const ImageError(
                              isCompact: true,
                            ),
                            errorListener: (value) => true,
                          ),
                          if (item is GameVideo)
                            ColoredBox(
                              color: context.colors.scheme.surface.withValues(
                                alpha: 0.5,
                              ),
                              child: Icon(
                                Icons.play_circle_fill_sharp,
                                size: context.textStyles.displayLarge.fontSize,
                                color: context.colors.scheme.onSurfaceVariant,
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
