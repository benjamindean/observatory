import 'package:emulators/emulators.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

final List<String> testColorSchemes = [
  'color-scheme-blue',
  'color-scheme-sakura',
  'color-scheme-gold'
];

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

  toggleTheme(String theme) async {
    await driver.tap(find.byTooltip('Go to Settings'));
    await driver.waitFor(find.text('Appearance'));
    await driver.tap(find.byValueKey('theme-toggle-$theme'));
    await driver.tap(find.pageBack());
  }

  toggleColorScheme(String scheme) async {
    await driver.tap(find.byTooltip('Go to Settings'));
    await driver.waitFor(find.text('Appearance'));
    await driver.tap(find.byValueKey('theme-toggle-dark'));

    await driver.scrollUntilVisible(
      find.byValueKey('color-scheme-list'),
      find.byValueKey(scheme),
      dxScroll: -300,
      timeout: const Duration(minutes: 1),
    );

    await driver.tap(find.byValueKey(scheme));
    await driver.tap(find.pageBack());
  }

  test('Deals Page', () async {
    await toggleTheme('dark');

    await driver.tap(find.byValueKey('navigation-deals'));
    await driver.tap(find.byValueKey('deal-category-all'));

    await takeScreenshot('deals_page');

    await driver.tap(find.byValueKey('navigation-deals'));

    await takeScreenshot('deals_page_filters');

    await driver.tap(find.byType('ModalBarrier'));
  });

  test('Waitlist Page', () async {
    await driver.tap(find.byValueKey('navigation-waitlist'));

    await takeScreenshot('waitlist_page');

    await driver.tap(find.byValueKey('navigation-waitlist'));

    await takeScreenshot('waitlist_page_filters');

    await driver.tap(find.byType('ModalBarrier'));
  });

  test('Search Page', () async {
    await driver.tap(find.byValueKey('navigation-search'));
    await driver.waitFor(find.byValueKey('search-scroll-view'));

    await takeScreenshot('search_page');
  });

  test('Deal Page', () async {
    await driver.tap(find.byValueKey('navigation-waitlist'));
    await driver.waitFor(find.byValueKey('waitlist-scroll-view'));
    await driver.tap(find.text('Lies Of P'));
    await driver.waitFor(find.byValueKey('deal-scroll-view'));

    await takeScreenshot('deal_page_top');

    await driver.scroll(
      find.byValueKey('deal-scroll-view'),
      0,
      -1000,
      const Duration(milliseconds: 300),
    );

    await takeScreenshot('deal_page');

    await driver.tap(find.pageBack());
  });

  test('Change Theme', () async {
    await takeScreenshot('waitlist_page');

    await toggleTheme('light');

    await takeScreenshot('waitlist_page_light');

    await driver.tap(find.byValueKey('navigation-deals'));

    await takeScreenshot('deals_page_light');

    await driver.tap(find.byValueKey('navigation-waitlist'));

    await toggleTheme('dark');

    for (String scheme in testColorSchemes) {
      await toggleColorScheme(scheme);
      await driver.waitFor(find.byValueKey('waitlist-scroll-view'));

      await takeScreenshot('waitlist_page_$scheme');
    }
  });
}
