import 'dart:io';

import 'package:emulators/emulators.dart';

Future<void> main() async {
  List<String> emulatorIds = [
    'iPhone 8 Plus',
  ];

  return runFlutterScreenshotTests(emulatorIds);
}

Future<ProcessResult> runFlutterIntegrationTests(
  DeviceState state,
) async {
  return Process.run('flutter', [
    'drive',
    '-d',
    state.id,
    '--driver=test_driver/integration_test.dart',
    '--target=integration_test/main_test.dart',
  ], environment: {
    'DEVICE_NAME': state.name
  });
}

Future<void> runFlutterScreenshotTests(List<String> emulatorIds) async {
  final Emulators emulators = await Emulators.build();

  await emulators.forEach(emulatorIds)((device) async {
    await runFlutterIntegrationTests(device.state);
    await emulators.drive(device, 'integration_test/main_test.dart');
  });
}
