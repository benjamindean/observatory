import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:observatory/shared/ui/constants.dart';

extension BuildContextEntension<T> on BuildContext {
  bool get isMobile => MediaQuery.of(this).size.width <= 500.0;

  bool get isTablet =>
      MediaQuery.of(this).size.width < 1024.0 &&
      MediaQuery.of(this).size.width >= 650.0;

  String? get semiBoldFont => GoogleFonts.notoSans(
        fontWeight: FontWeight.w500,
      ).fontFamily;

  Color get elevatedCanvasColor => ElevationOverlay.applySurfaceTint(
        colors.scheme.surfaceContainer,
        colors.scheme.surfaceTint,
        1,
      );

  Color get elevatedBottomAppBarColor => ElevationOverlay.applySurfaceTint(
        colors.scheme.surfaceContainer,
        colors.scheme.surfaceTint,
        APPBAR_ELEVATION,
      );

  Color get midElevatedCanvasColor => ElevationOverlay.applySurfaceTint(
        colors.scheme.surfaceContainer,
        colors.scheme.surfaceTint,
        8,
      );

  Color get highElevatedCanvasColor => ElevationOverlay.applySurfaceTint(
        colors.scheme.surfaceContainer,
        colors.scheme.surfaceTint,
        15,
      );
}
