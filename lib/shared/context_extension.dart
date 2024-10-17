import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:observatory/shared/ui/constants.dart';

extension IterableExtension<T> on List<T> {
  Iterable<T> distinctBy(Object Function(T e) getCompareValue) {
    var idSet = <Object>{};
    var distinct = <T>[];

    for (final d in this) {
      if (idSet.add(getCompareValue(d))) {
        distinct.add(d);
      }
    }

    return distinct;
  }
}

extension BuildContextEntension<T> on BuildContext {
  bool get isMobile => MediaQuery.of(this).size.width <= 500.0;

  bool get isTablet =>
      MediaQuery.of(this).size.width < 1024.0 &&
      MediaQuery.of(this).size.width >= 650.0;

  String? get semiBoldFont => GoogleFonts.openSans(
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
