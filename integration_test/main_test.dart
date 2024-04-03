import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'utils/app.dart';

void main() async {
  final IntegrationTestWidgetsFlutterBinding binding =
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    WidgetsApp.debugAllowBannerOverride = false;

    await initDependencies();
  });

  testWidgets('Deals Page', (widgetTester) async {
    await runObservatory(widgetTester);

    await binding.convertFlutterSurfaceToImage();
    await widgetTester.pumpAndSettle();
    await binding.takeScreenshot('main');
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

    await binding.convertFlutterSurfaceToImage();
    await widgetTester.pumpAndSettle();
    await binding.takeScreenshot('deal_page');
  });
}
