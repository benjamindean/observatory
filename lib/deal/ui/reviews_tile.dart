import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:observatory/deal/info_provider.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/models/info.dart';
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

    return ListTile(
      dense: true,
      title: Text(
        'Reviews',
        style: context.themes.text.labelLarge?.copyWith(
          color: context.colors.hint,
        ),
      ),
      subtitle: AnimatedSwitcher(
        layoutBuilder: (
          Widget? currentChild,
          List<Widget> previousChildren,
        ) {
          return Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              ...previousChildren,
              if (currentChild != null) currentChild,
            ],
          );
        },
        duration: const Duration(milliseconds: 200),
        child: infoState.when(
          data: (info) {
            final Review? review =
                info?.reviews.where((e) => e.score != null).firstOrNull;

            if (review == null) {
              return Text(
                'No reviews available.',
                style: context.themes.text.labelLarge?.copyWith(
                  color: context.colors.disabled,
                ),
              );
            }

            return RichText(
              text: TextSpan(
                style: context.themes.text.labelLarge?.copyWith(
                  color: context.colors.scheme.onBackground,
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
          loading: () => LinearProgressIndicator(
            borderRadius: BorderRadius.circular(12.0),
            minHeight: 2,
            color: context.colors.scheme.onSurfaceVariant,
          ),
          error: (error, stackTrace) {
            Logger().e(
              'Failed to load info',
              error: error,
              stackTrace: stackTrace,
            );

            FirebaseCrashlytics.instance.recordError(
              error,
              stackTrace,
            );

            return Text(
              'Unknown',
              style: context.themes.text.labelLarge?.copyWith(
                color: context.colors.disabled,
              ),
            );
          },
        ),
      ),
    );
  }
}
