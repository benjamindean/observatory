import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:observatory/deal/igdb_search_provider.dart';
import 'package:observatory/deal/ui/page_sections/deal_page_section_async.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/models/igdb/igdb_game.dart';
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

    final AsyncValue<IGDBGame?> igdbState = ref.watch(
      igdbSearchProvider(deal.titleParsed),
    );

    void openGallery(
      BuildContext context,
      final int index,
      final List<IGDBScreenshot> screenshots,
    ) {
      showDialog(
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.7),
        context: context,
        builder: (context) {
          return Scaffold(
            bottomNavigationBar: BottomAppBar(
              shadowColor: Colors.transparent,
              color: Colors.transparent,
              key: Key('deal-page-bottom-app-bar-${deal.id}'),
              elevation: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    flex: 50,
                    child: BackButton(
                      key: const Key('observatory-back-button-screenshot'),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white10,
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 50,
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
                  final IGDBScreenshot screenshot = screenshots[index];

                  return PhotoViewGalleryPageOptions(
                    tightMode: true,
                    heroAttributes: PhotoViewHeroAttributes(
                      tag: index,
                      transitionOnUserGestures: true,
                    ),
                    imageProvider: CachedNetworkImageProvider(
                      screenshot.getURL(size: ScreenshotSize.fullHD) ?? '',
                    ),
                  );
                },
                itemCount: screenshots.length,
              ),
            ),
          );
        },
      );
    }

    return DealPageSectionAsync<IGDBGame?>(
      state: igdbState,
      deal: deal,
      heading: 'Screenshots',
      onData: (data) {
        if (data == null || data.screenshots.isEmpty) {
          return Text(
            key: const Key('no-screenshots'),
            'No screenshots available.',
            style: context.themes.text.labelLarge?.copyWith(
              color: context.colors.disabled,
            ),
          );
        }

        return SizedBox(
          key: Key('screenshots-tile-${deal.id}'),
          height: 360 / thumbDelimiter,
          child: ListView.builder(
            itemCount: data.screenshots.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final IGDBScreenshot screenshot = data.screenshots[index];

              return GestureDetector(
                onTap: () => openGallery(
                  context,
                  index,
                  data.screenshots,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: context.colors.scheme.surface,
                    ),
                    width: 569 / thumbDelimiter,
                    height: 320 / thumbDelimiter,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Hero(
                        tag: index,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          fadeInDuration: const Duration(milliseconds: 100),
                          imageUrl: screenshot.getURL() ?? '',
                          placeholder: (context, url) => const Opacity(
                            opacity: 0.3,
                            child: ObservatoryProgressIndicator(
                              size: 30,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const ImageError(
                            isCompact: true,
                          ),
                          errorListener: (value) => true,
                        ),
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
