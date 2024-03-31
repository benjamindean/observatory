import 'dart:math';
import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    return EasyRefresh(
      header: BuilderHeader(
        processedDuration: Duration.zero,
        position: IndicatorPosition.locator,
        triggerOffset: 50.0,
        maxOverOffset: 70.0,
        clamping: false,
        builder: (context, state) {
          return Container(
            color: context.colors.scheme.primaryContainer,
            height: state.offset,
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
              child: Builder(
                builder: (context) {
                  switch (state.mode) {
                    case IndicatorMode.processed:
                    case IndicatorMode.done:
                      return const SizedBox.shrink();
                    case IndicatorMode.processing:
                      return Center(
                        child: Transform.scale(
                          scale: 0.8,
                          child: CircularProgressIndicator(
                            color: context.colors.scheme.onPrimaryContainer,
                          ),
                        ),
                      );
                    default:
                      return Opacity(
                        opacity: opacityCurve.transform(
                          min(state.offset / 50.0, 1.0),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  Icons.arrow_downward_rounded,
                                  size: context.textStyles.titleLarge.fontSize,
                                  color:
                                      context.colors.scheme.onPrimaryContainer,
                                ),
                              ),
                              Text(
                                'Pull to refresh',
                                style: context.textStyles.labelLarge.copyWith(
                                  color:
                                      context.colors.scheme.onPrimaryContainer,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
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
        HapticFeedback.lightImpact();

        return onRefresh();
      },
      child: child,
    );
  }
}
