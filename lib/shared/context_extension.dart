import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:observatory/shared/ui/constants.dart';

extension BuildContextEntension<T> on BuildContext {
  bool get isMobile => MediaQuery.of(this).size.width <= 500.0;

  bool get isTablet =>
      MediaQuery.of(this).size.width < 1024.0 &&
      MediaQuery.of(this).size.width >= 650.0;

  Color get elevatedCanvasColor => ElevationOverlay.applySurfaceTint(
        colors.scheme.surface,
        colors.scheme.surfaceTint,
        1,
      );

  Color get elevatedBottomAppBarColor => ElevationOverlay.applySurfaceTint(
        colors.scheme.surface,
        colors.scheme.surfaceTint,
        APPBAR_ELEVATION,
      );

  Color get highElevatedCanvasColor => ElevationOverlay.applySurfaceTint(
        colors.scheme.surface,
        colors.scheme.surfaceTint,
        10,
      );
}
