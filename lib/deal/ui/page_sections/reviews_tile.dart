import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/deal/providers/info_provider.dart';
import 'package:observatory/deal/ui/page_sections/deal_page_section_async.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/models/info.dart';
import 'package:observatory/shared/models/review.dart';
import 'package:observatory/shared/ui/constants.dart';
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
    final AsyncValue<Info?> infoState = ref.watch(
      infoProvider(deal.id),
    );

    return DealPageSectionAsync<Info?>(
      state: infoState,
      deal: deal,
      heading: 'Reviews',
      onData: (info) {
        final Review? review =
            info?.reviews.where((e) => e.score != null).firstOrNull;

        if (review == null) {
          return Text(
            'No reviews available.',
            key: const Key('no-reviews'),
            style: context.themes.text.labelLarge?.copyWith(
              color: context.colors.disabled,
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Chip(
            surfaceTintColor: context.colors.scheme.surfaceTint,
            elevation: CARD_ELEVATION,
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${review.score.toString()}%',
                  style: context.textStyles.labelLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: getReviewColor(context, review),
                  ),
                ),
                const DotSeparator(),
                Text(
                  review.source.toString(),
                  style: context.textStyles.labelLarge.copyWith(
                    color: context.colors.scheme.onSurface,
                  ),
                ),
              ],
            ),
            padding: const EdgeInsets.all(6.0),
            visualDensity: VisualDensity.compact,
            side: BorderSide.none,
          ),
        );
      },
    );
  }
}
