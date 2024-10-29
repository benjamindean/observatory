import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:observatory/deal/ui/page_sections/screenshots/youtube_video.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/models/game/game.dart';
import 'package:observatory/shared/widgets/progress_indicator.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryView extends StatelessWidget {
  final Deal deal;
  final int index;
  final List<GameScreenshot> screenshots;
  final List<GameVideo> videos;

  const GalleryView({
    super.key,
    required this.deal,
    required this.index,
    required this.screenshots,
    required this.videos,
  });

  @override
  Widget build(BuildContext context) {
    final List media = [...screenshots, ...videos];

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      bottomNavigationBar: BottomAppBar(
        shadowColor: Colors.transparent,
        color: Colors.transparent,
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              flex: 40,
              child: BackButton(
                color: Colors.white30,
                key: const Key('observatory-back-button-screenshot'),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white10,
                ),
              ),
            ),
            const Expanded(
              flex: 60,
              child: SizedBox.expand(),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      body: Dismissible(
        key: Key('gallery-${deal.id}'),
        onDismissed: (direction) {
          return context.pop();
        },
        resizeDuration: const Duration(milliseconds: 1),
        direction: DismissDirection.vertical,
        child: PhotoViewGallery.builder(
          allowImplicitScrolling: true,
          pageController: PageController(initialPage: index),
          gaplessPlayback: true,
          backgroundDecoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          loadingBuilder: (context, event) => const Center(
            child: ObservatoryProgressIndicator(
              size: 40,
            ),
          ),
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (context, index) {
            final item = media[index];

            if (item is GameVideo && item.video_id != null) {
              if (item.isYouTube) {
                return PhotoViewGalleryPageOptions.customChild(
                  child: YouTubeVideo(
                    videoId: item.video_id!,
                  ),
                );
              }
            }

            return PhotoViewGalleryPageOptions(
              tightMode: true,
              minScale: PhotoViewComputedScale.contained,
              imageProvider: CachedNetworkImageProvider(
                item.getURL(size: ScreenshotSize.full) ?? '',
              ),
            );
          },
          itemCount: media.length,
        ),
      ),
    );
  }
}
