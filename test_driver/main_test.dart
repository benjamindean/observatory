import 'dart:io';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() async {
  final FlutterDriver driver = await FlutterDriver.connect();

  await integrationDriver(
    driver: driver,
    onScreenshot: (screenshotName, screenshotBytes, [args]) async {
      final File image = await File('screenshots/$screenshotName.png').create(
        recursive: true,
      );

      image.writeAsBytesSync(screenshotBytes);

      return true;
    },
  );
}
