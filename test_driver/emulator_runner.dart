import 'dart:io';

import 'package:emulators/emulators.dart';
import 'package:logger/logger.dart';

Future<void> main() async {
  final List<String> emulatorIds = [
    'iPhone 14 Pro Max',
    'iPhone 8 Plus',
    'iPad Pro (12.9-inch) (2nd generation)',
    'iPad Pro (12.9-inch) (6th generation)'
  ];
  Logger().d('Running tests on emulators: ${emulatorIds.join(', ')}');

  final Emulators emulators = await Emulators.build();

  await emulators.shutdownAll();

  await emulators.forEach(emulatorIds)((device) async {
    Logger().d('Starting emulator: ${device.state.name} (${device.state.id})');

    final Process process = await emulators.drive(
      device,
      'test_driver/screenshot.dart',
      config: {'locale': 'en'},
    );

    await stdout.addStream(process.stdout);
    await stderr.addStream(process.stderr);
  });
}
