import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ObservatoryProgressIndicator extends StatelessWidget {
  final double size;

  const ObservatoryProgressIndicator({
    super.key,
    this.size = 60,
  });

  @override
  Widget build(BuildContext context) {
    return SpinKitDualRing(
      lineWidth: 3.0,
      color: context.colors.scheme.primary,
      size: size,
    );
  }
}
