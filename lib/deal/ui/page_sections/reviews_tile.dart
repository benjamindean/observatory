import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/deal/combined_details_provider.dart';
import 'package:observatory/deal/ui/page_sections/deal_page_section_async.dart';
import 'package:observatory/shared/models/combined_details.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/models/review.dart';
import 'package:observatory/shared/ui/dot_separator.dart';

class ReviewsTile extends ConsumerWidget {
  final Deal deal;

  const ReviewsTile({
    super.key,
    required this.deal,
  });

  Color getReviewColor(BuildContext context, Review review) {
    if (review.score == null) {
      return context.colors.disabled;
    }

    if (review.score! >= 80) {
      return context.colors.scheme.primary;
    }

    if (review.score! < 60) {
      return context.colors.scheme.tertiary;
    }

    if (review.score! < 80) {
      return context.colors.scheme.secondary;
    }

    return context.colors.scheme.error;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<CombinedDetails> infoState = ref.watch(
      combinedDetailsProvider(deal),
    );

    return DealPageSectionAsync<CombinedDetails>(
      state: infoState,
      deal: deal,
      heading: 'Reviews',
      onData: (info) {
        final Review? review =
            info.itad?.reviews.where((e) => e.score != null).firstOrNull;

        if (review == null) {
          return Text(
            'No reviews available.',
            key: const Key('no-reviews'),
            style: context.themes.text.labelLarge?.copyWith(
              color: context.colors.disabled,
            ),
          );
        }

        return RichText(
          key: Key('reviews-tile-${deal.id}'),
          text: TextSpan(
            style: context.themes.text.labelLarge?.copyWith(
              color: context.colors.scheme.onSurface,
            ),
            children: [
              TextSpan(
                text: '${review.score.toString()}%',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: getReviewColor(context, review),
                ),
              ),
              DotSeparator.textSpan(context),
              TextSpan(
                text: review.source,
              ),
            ],
          ),
        );
      },
    );
  }
}
