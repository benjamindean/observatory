import 'dart:io';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() async {
  final FlutterDriver driver = await FlutterDriver.connect();
  final String deviceName = Platform.environment['DEVICE_NAME'] ?? '';
  final String devicePrefix = deviceName.isEmpty ? '' : '${deviceName}_';

  await integrationDriver(
    driver: driver,
    onScreenshot: (screenshotName, screenshotBytes, [args]) async {
      final File image = await File(
        'screenshots/$devicePrefix$screenshotName.png',
      ).create(
        recursive: true,
      );

      image.writeAsBytesSync(screenshotBytes);

      return true;
    },
  );
}
