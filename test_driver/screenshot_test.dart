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

    await driver.tap(find.byValueKey('navigation_deals'));

    await takeScreenshot('deals_page_filters');

    await driver.scroll(
      find.byValueKey('deals_filter_all'),
      0,
      1000,
      const Duration(milliseconds: 200),
    );
  });

  test('Waitlist Page', () async {
    await driver.tap(find.byValueKey('navigation_waitlist'));
    await driver.waitFor(find.byValueKey('waitlist_scroll_view'));

    await takeScreenshot('waitlist_page');

    await driver.tap(find.byValueKey('navigation_waitlist'));

    await takeScreenshot('waitlist_page_filters');

    await driver.scroll(
      find.byValueKey('waitlist_sorting_title'),
      0,
      1000,
      const Duration(milliseconds: 200),
    );
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

    await takeScreenshot('deal_page_top');

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
    final List<String> schemes = [
      'color_scheme_blue',
      'color_scheme_sakura',
      'color_scheme_gold'
    ];

    await driver.tap(find.byTooltip('Go to Settings'));
    await driver.waitFor(find.text('Appearance'));
    await driver.tap(find.byValueKey('theme_togge_light'));
    await driver.tap(find.pageBack());
    await driver.waitFor(find.byValueKey('waitlist_scroll_view'));

    await takeScreenshot('waitlist_page_light');

    for (String scheme in schemes) {
      await driver.tap(find.byTooltip('Go to Settings'));
      await driver.waitFor(find.text('Appearance'));
      await driver.tap(find.byValueKey('theme_togge_dark'));

      await driver.scrollUntilVisible(
        find.byValueKey('color_scheme_list'),
        find.byValueKey(scheme),
      );

      await driver.tap(find.byValueKey(scheme));
      await driver.tap(find.pageBack());
      await driver.waitFor(find.byValueKey('waitlist_scroll_view'));

      await takeScreenshot('waitlist_page_$scheme');
    }
  });
}
