import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:observatory/deal/providers/game_details_provider.dart';
import 'package:observatory/deal/ui/page_sections/deal_page_section_async.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/models/game/game.dart';
import 'package:observatory/shared/ui/constants.dart';
import 'package:observatory/shared/widgets/image_error.dart';
import 'package:observatory/shared/widgets/progress_indicator.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ScreenshotsTile extends ConsumerWidget {
  final Deal deal;

  const ScreenshotsTile({
    super.key,
    required this.deal,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const double thumbDelimiter = 2.5;

    final AsyncValue<GameDetails?> infoState = ref.watch(
      gameDetailsProvider(Deal(id: deal.id, title: deal.title)),
    );

    void openGallery(
      BuildContext context,
      final int index,
      final List<GameScreenshot> screenshots,
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
          );
        },
      );
    }

    return DealPageSectionAsync<GameDetails?>(
      state: infoState,
      deal: deal,
      heading: 'Screenshots',
      onData: (data) {
        final List<GameScreenshot> screenshots = data?.screenshots ?? [];

        if (screenshots.isEmpty) {
          return Text(
            key: const Key('no-screenshots'),
            'No screenshots available.',
            style: context.themes.text.labelLarge?.copyWith(
              color: context.colors.disabled,
            ),
          );
        }

        return SizedBox(
          height: SCREENSHOT_HEIGHT / thumbDelimiter,
          child: ListView.builder(
            itemExtent: SCREENSHOT_WIDTH / thumbDelimiter,
            itemCount: screenshots.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final GameScreenshot screenshot = screenshots[index];

              return GestureDetector(
                onTap: () => openGallery(
                  context,
                  index,
                  screenshots,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: context.colors.scheme.surface,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        fadeInDuration: const Duration(milliseconds: 200),
                        fadeOutDuration: const Duration(milliseconds: 200),
                        imageUrl: screenshot.getURL() ?? '',
                        placeholder: (context, url) => const ImageError(
                          isCompact: true,
                        ),
                        errorWidget: (context, url, error) => const ImageError(
                          isCompact: true,
                        ),
                        errorListener: (value) => true,
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

class GalleryView extends StatelessWidget {
  final Deal deal;
  final int index;
  final List<GameScreenshot> screenshots;

  const GalleryView({
    super.key,
    required this.deal,
    required this.index,
    required this.screenshots,
  });

  @override
  Widget build(BuildContext context) {
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
            final GameScreenshot screenshot = screenshots[index];

            return PhotoViewGalleryPageOptions(
              tightMode: true,
              minScale: PhotoViewComputedScale.contained,
              imageProvider: CachedNetworkImageProvider(
                screenshot.getURL(size: ScreenshotSize.full) ?? '',
              ),
            );
          },
          itemCount: screenshots.length,
        ),
      ),
    );
  }
}
