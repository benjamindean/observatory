import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';

extension BuildContextEntension<T> on BuildContext {
  bool get isMobile => MediaQuery.of(this).size.width <= 500.0;

  bool get isTablet =>
      MediaQuery.of(this).size.width < 1024.0 &&
      MediaQuery.of(this).size.width >= 650.0;

  Color get elevatedCanvasColor => ElevationOverlay.applySurfaceTint(
        colors.canvas,
        colors.scheme.surfaceTint,
        3,
      );

  Color get highElevatedCanvasColor => ElevationOverlay.applySurfaceTint(
        colors.canvas,
        colors.scheme.surfaceTint,
        20,
      );
}
