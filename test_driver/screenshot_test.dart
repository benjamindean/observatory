import 'package:emulators/emulators.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() async {
  final FlutterDriver driver = await FlutterDriver.connect();
  final Emulators emulators = await Emulators.build();
  final ScreenshotHelper screenshot = emulators.screenshotHelper(
    androidPath: 'screenshots/android',
    iosPath: 'screenshots/ios',
  );

  setUpAll(() async {
    await driver.waitUntilFirstFrameRasterized();
    await screenshot.cleanStatusBar();
  });

  tearDownAll(() async {
    await driver.close();
  });

  takeScreenshot(identifier) async {
    await driver.waitUntilNoTransientCallbacks(
      timeout: const Duration(seconds: 10),
    );
    await screenshot.capture(identifier);
  }

  test('Deals Page', () async {
    await driver.tap(find.byTooltip('Go to Settings'));
    await driver.waitFor(find.text('Appearance'));
    await driver.tap(find.byValueKey('theme_togge_dark'));
    await driver.tap(find.pageBack());
    await driver.waitFor(find.byValueKey('deals_scroll_view'));

    await takeScreenshot('deals_page');
  });

  test('Waitlist Page', () async {
    await driver.tap(find.byValueKey('navigation_waitlist'));
    await driver.waitFor(find.byValueKey('waitlist_scroll_view'));

    await takeScreenshot('waitlist_page');
  });

  test('Search Page', () async {
    await driver.tap(find.byValueKey('navigation_search'));
    await driver.waitFor(find.byValueKey('search_scroll_view'));

    await takeScreenshot('search_page');
  });

  test('Deal Page', () async {
    await driver.tap(find.byValueKey('navigation_waitlist'));
    await driver.waitFor(find.byValueKey('waitlist_scroll_view'));
    await driver.tap(find.text('Lies Of P'));
    await driver.waitFor(find.byValueKey('deal_scroll_view'));

    await driver.scroll(
      find.byValueKey('deal_scroll_view'),
      0,
      -1000,
      const Duration(milliseconds: 300),
    );

    await takeScreenshot('deal_page');

    await driver.tap(find.pageBack());
  });

  test('Change Theme', () async {
    await driver.tap(find.byTooltip('Go to Settings'));
    await driver.waitFor(find.text('Appearance'));
    await driver.tap(find.byValueKey('theme_togge_light'));
    await driver.tap(find.pageBack());
    await driver.waitFor(find.byValueKey('waitlist_scroll_view'));

    await takeScreenshot('waitlist_page_light');
  });
}
