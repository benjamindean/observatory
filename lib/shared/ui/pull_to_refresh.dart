import 'dart:math';
import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:observatory/shared/widgets/progress_indicator.dart';

const Curve opacityCurve = Interval(
  0.3,
  1.0,
  curve: Curves.easeInOut,
);

class PullToRefresh extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;

  const PullToRefresh({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    ValueKey indicatorKey = const ValueKey<IndicatorMode>(
      IndicatorMode.inactive,
    );

    return EasyRefresh(
      header: BuilderHeader(
        processedDuration: Duration.zero,
        position: IndicatorPosition.locator,
        triggerOffset: const SliverAppBar().toolbarHeight + 50,
        springRebound: false,
        clamping: false,
        safeArea: false,
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.only(top: 8.0),
            color: context.colors.scaffoldBackground,
            height: state.offset,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Builder(
                key: state.mode == IndicatorMode.ready
                    ? indicatorKey
                    : indicatorKey = ValueKey<IndicatorMode>(state.mode),
                builder: (context) {
                  switch (state.mode) {
                    case IndicatorMode.ready:
                    case IndicatorMode.armed:
                      return Icon(
                        Icons.refresh,
                        size: 40.0,
                        color: context.colors.scheme.primary,
                      );
                    case IndicatorMode.processed:
                    case IndicatorMode.done:
                      return const SizedBox.shrink();
                    case IndicatorMode.processing:
                      return const Center(
                        child: ObservatoryProgressIndicator(
                          size: 25.0,
                        ),
                      );
                    default:
                      return Opacity(
                        opacity: opacityCurve.transform(
                          min(state.offset / 50.0, 1.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_downward_rounded,
                              size: context.textStyles.titleLarge.fontSize,
                              color: context.colors.scheme.primary,
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              'Pull to refresh',
                              style: context.textStyles.labelLarge.copyWith(
                                color: context.colors.scheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                  }
                },
              ),
            ),
          );
        },
      ),
      onRefresh: () async {
        HapticFeedback.mediumImpact();

        return onRefresh();
      },
      child: child,
    );
  }
}
