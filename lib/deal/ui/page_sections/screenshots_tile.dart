import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/deal/igdb_search_provider.dart';
import 'package:observatory/deal/ui/page_sections/deal_page_section_async.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/models/igdb/igdb_game.dart';
import 'package:observatory/shared/widgets/image_error.dart';
import 'package:observatory/shared/widgets/progress_indicator.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class SscreenshotsTile extends ConsumerWidget {
  final Deal deal;

  const SscreenshotsTile({
    super.key,
    required this.deal,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<IGDBGame?> igdbState = ref.watch(
      igdbSearchProvider(deal.titleParsed),
    );

    void openGallery(
      BuildContext context,
      final int index,
      final List<IGDBScreenshot> screenshots,
    ) {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        shape: const ContinuousRectangleBorder(),
        isScrollControlled: true,
        builder: (context) {
          return PhotoViewGestureDetectorScope(
            axis: Axis.vertical,
            child: PhotoViewGallery.builder(
              pageController: PageController(initialPage: index),
              gaplessPlayback: true,
              backgroundDecoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
              ),
              loadingBuilder: (context, event) => Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                ),
                child: const Center(
                  child: ObservatoryProgressIndicator(
                    size: 40,
                  ),
                ),
              ),
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (context, index) {
                final IGDBScreenshot screenshot = screenshots[index];

                return PhotoViewGalleryPageOptions(
                  imageProvider: CachedNetworkImageProvider(
                    screenshot.getURL() ?? '',
                  ),
                );
              },
              itemCount: screenshots.length,
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
            'No screenshots available.',
            style: context.themes.text.labelLarge?.copyWith(
              color: context.colors.disabled,
            ),
          );
        }

        return SizedBox(
          height: 120,
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
                    color: context.colors.scheme.surface,
                    height: 120,
                    width: 200,
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
                      errorWidget: (context, url, error) => const ImageError(
                        isCompact: true,
                      ),
                      errorListener: (value) => true,
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
