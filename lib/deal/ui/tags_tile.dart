import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:observatory/deal/info_provider.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/models/info.dart';

class TagsTile extends ConsumerWidget {
  final Deal deal;

  const TagsTile({
    super.key,
    required this.deal,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Info?> infoState = ref.watch(
      infoProvider(deal.id),
    );

    return ListTile(
      dense: true,
      isThreeLine: false,
      title: Text(
        'Tags',
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
            final List<String>? tags = info?.tags;

            if (tags == null || tags.isEmpty) {
              return Text(
                'No tags available.',
                style: context.themes.text.labelLarge?.copyWith(
                  color: context.colors.disabled,
                ),
              );
            }

            return Wrap(
              children: List<Widget>.generate(
                tags.length,
                (int idx) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Chip(
                      label: Text(
                        tags[idx],
                        textScaler: const TextScaler.linear(0.9),
                        style: context.themes.text.labelLarge?.copyWith(
                          color: context.colors.scheme.onBackground,
                        ),
                      ),
                      backgroundColor:
                          context.colors.scheme.surfaceVariant.withOpacity(
                        0.3,
                      ),
                      padding: const EdgeInsets.all(6.0),
                      visualDensity: VisualDensity.compact,
                      side: BorderSide.none,
                    ),
                  );
                },
              ),
            );

            // return RichText(
            //   text: TextSpan(
            //     children: List<TextSpan>.generate(
            //       tags.length,
            //       (int idx) {
            //         return TextSpan(
            //           children: [
            //             TextSpan(
            //               text: tags[idx],
            //             ),
            //             if (idx < tags.length - 1)
            //               TextSpan(
            //                 text: ' • ',
            //                 style: TextStyle(color: context.colors.disabled),
            //               )
            //           ],
            //           style: context.themes.text.labelLarge?.copyWith(
            //             color: context.colors.scheme.onBackground,
            //           ),
            //         );
            //       },
            //     ).toList(),
            //   ),
            // );
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
