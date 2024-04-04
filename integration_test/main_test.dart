import 'dart:io';

import 'package:emulators/emulators.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'utils/app.dart';

/// Run with:
/// flutter drive --driver=test_driver/main_test.dart --target integration_test/main_test.dart//
/// dart test_driver/emulator_runner.dart

void main() async {
  const androidScreenshotPath = 'screenshots/store/android';
  const iosScreenshotPath = 'screenshots/store/ios';

  final IntegrationTestWidgetsFlutterBinding binding =
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final emulators = await Emulators.build();
  final screenshot = emulators.screenshotHelper(
    androidPath: androidScreenshotPath,
    iosPath: iosScreenshotPath,
  );

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    WidgetsApp.debugAllowBannerOverride = false;

    if (Platform.isAndroid) {
      await binding.convertFlutterSurfaceToImage();
    }

    await screenshot.cleanStatusBar();
    await initDependencies();
  });

  testWidgets('Deals Page', (widgetTester) async {
    await runObservatory(widgetTester);

    await screenshot.capture('deals_page');
  });

  testWidgets('Waitlist Page', (widgetTester) async {
    await runObservatory(widgetTester);

    final waitlistButton = find.text('Waitlist');

    expect(waitlistButton, findsOneWidget);

    await widgetTester.tap(waitlistButton);
    await widgetTester.pumpAndSettle();

    await binding.convertFlutterSurfaceToImage();
    await widgetTester.pumpAndSettle();
    await binding.takeScreenshot('waitlist');
  });

  testWidgets('Deal Page', (widgetTester) async {
    await runObservatory(widgetTester);

    final liesOfP = find.text('Lies Of P');

    expect(liesOfP, findsOneWidget);

    await widgetTester.tap(liesOfP);
    await widgetTester.pumpAndSettle();

    await widgetTester.scrollUntilVisible(
      find.byKey(const ValueKey('is_there_any_deal_info')),
      50.0,
      scrollable: find.byType(Scrollable),
    );
    await widgetTester.pumpAndSettle();

    expect(find.text('\$59.99'), findsExactly(3));
    expect(find.text('\$41.99'), findsExactly(1));
    expect(find.text('\$49.79'), findsExactly(1));

    await screenshot.capture('deal_page');

    await widgetTester.tap(find.byType(BackButton));
    await widgetTester.pumpAndSettle();
  });

  testWidgets('Search Page', (widgetTester) async {
    await runObservatory(widgetTester);

    await widgetTester.tap(find.text('Search'));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.text('Search Now'));
    await widgetTester.pumpAndSettle();

    await widgetTester.enterText(find.byType(TextField), 'Danganronpa');
    await widgetTester.testTextInput.receiveAction(TextInputAction.done);
    await widgetTester.pumpAndSettle();

    await screenshot.capture('search_page');
  });
}
