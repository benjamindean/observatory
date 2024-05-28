import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ObservatoryProgressIndicator extends StatelessWidget {
  final double size;
  final double lineWidth;

  const ObservatoryProgressIndicator({
    super.key,
    this.size = 60,
    this.lineWidth = 3.0,
  });

  @override
  Widget build(BuildContext context) {
    return SpinKitDualRing(
      key: const Key('progress_indicator'),
      lineWidth: lineWidth,
      color: context.colors.scheme.primary,
      size: size,
    );
  }
}

class ObservatoryIconProgressIndicator extends StatelessWidget {
  const ObservatoryIconProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 24,
      height: 24,
      child: ObservatoryProgressIndicator(
        size: 16.0,
        lineWidth: 1.5,
      ),
    );
  }
}
