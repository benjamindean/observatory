import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:integration_test/src/channel.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

Future<void> takeScreenshot(WidgetTester tester, String name) async {
  final IntegrationTestWidgetsFlutterBinding binding =
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await integrationTestChannel.invokeMethod<void>(
      'convertFlutterSurfaceToImage',
    );
  }

  await tester.pump();

  binding.reportData ??= <String, dynamic>{};
  binding.reportData!['screenshots'] ??= <dynamic>[];

  integrationTestChannel.setMethodCallHandler((MethodCall call) async {
    switch (call.method) {
      case 'scheduleFrame':
        PlatformDispatcher.instance.scheduleFrame();
        break;
    }

    return null;
  });

  final rawBytes = await integrationTestChannel.invokeMethod<List<int>>(
    'captureScreenshot',
    <String, dynamic>{'name': name},
  );

  if (rawBytes == null) {
    throw StateError(
      'Expected a list of bytes, but instead captureScreenshot returned null',
    );
  }

  final data = <String, dynamic>{
    'screenshotName': name,
    'bytes': rawBytes,
  };

  assert(data.containsKey('bytes'), 'Missing bytes key');

  (binding.reportData!['screenshots'] as List<dynamic>).add(data);

  if (Platform.isAndroid) {
    await integrationTestChannel.invokeMethod<void>(
      'revertFlutterImage',
    );
  }
}
