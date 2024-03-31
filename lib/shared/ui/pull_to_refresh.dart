import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PullToRefresh extends StatelessWidget {
  final Future<void> Function() onRefresh;

  const PullToRefresh({
    super.key,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverRefreshControl(
      refreshTriggerPullDistance: 150,
      onRefresh: onRefresh,
      builder: (
        context,
        refreshState,
        pulledExtent,
        refreshTriggerPullDistance,
        refreshIndicatorExtent,
      ) {
        const Curve opacityCurve = Interval(
          0.4,
          1.0,
          curve: Curves.easeInOut,
        );

        if (refreshState == RefreshIndicatorMode.drag) {
          return Center(
            child: Opacity(
              opacity: opacityCurve.transform(
                min(pulledExtent / refreshTriggerPullDistance, 1.0),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.arrow_downward,
                      size: 24.0,
                    ),
                  ),
                  Text('Reload'),
                ],
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
