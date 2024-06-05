import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:observatory/shared/models/deal.dart';

class DealPageSectionAsync<T> extends StatelessWidget {
  final AsyncValue<T> state;
  final Deal deal;
  final Widget Function(T) onData;
  final String heading;

  const DealPageSectionAsync({
    super.key,
    required this.state,
    required this.deal,
    required this.onData,
    required this.heading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      key: Key('deal-page-section-$heading'),
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 4.0),
          child: Text(
            heading,
            style: context.themes.text.labelLarge?.copyWith(
              color: context.colors.hint,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
          child: AnimatedSwitcher(
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
            child: state.when(
              data: onData,
              loading: () => Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: LinearProgressIndicator(
                  borderRadius: BorderRadius.circular(12.0),
                  minHeight: 2,
                  color: context.colors.scheme.onSurfaceVariant,
                ),
              ),
              error: (error, stackTrace) {
                Logger().e(
                  'Failed to load $heading for ${deal.titleParsed}',
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
        ),
      ],
    );
  }
}
