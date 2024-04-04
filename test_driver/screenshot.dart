import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:observatory/main.dart' as app;

void main() {
  enableFlutterDriverExtension();
  WidgetsApp.debugAllowBannerOverride = false;
  app.main();
}
