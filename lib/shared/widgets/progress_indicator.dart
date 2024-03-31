import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ITADProgressIndicator extends StatelessWidget {
  final double size;

  const ITADProgressIndicator({
    super.key,
    this.size = 60,
  });

  @override
  Widget build(BuildContext context) {
    return SpinKitDoubleBounce(
      color: context.colors.scheme.onSurfaceVariant,
      size: size,
    );
  }
}
