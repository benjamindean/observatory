import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:observatory/deals/deals_provider.dart';
import 'package:observatory/firebase_options.dart';
import 'package:observatory/main.dart';
import 'package:observatory/secret_loader.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/api/api.dart';
import 'package:observatory/waitlist/waitlist_provider.dart';

import 'mocks/deals_mocks.dart';
import 'mocks/waitlist_mocks.dart';

void main() {
  testWidgets('Main Tests', (widgetTester) async {
    WidgetsApp.debugAllowBannerOverride = false;

    WidgetsFlutterBinding.ensureInitialized();

    await SettingsRepository.init();

    GetIt.I.registerSingleton<SettingsRepository>(SettingsRepository());
    GetIt.I.registerSingleton<API>(await API.create());
    GetIt.I.registerSingleton<Secret>(await SecretLoader.load());

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await FirebaseAppCheck.instance.activate();

    await widgetTester.pumpWidget(
      ProviderScope(
        overrides: [
          asyncWaitListProvider.overrideWith(AsyncWaitListNotifierMock.new),
          asyncDealsProvider.overrideWith(AsyncDealsNotifierMock.new),
        ],
        child: const Observatory(),
      ),
    );

    await widgetTester.pumpAndSettle();

    final waitlistButton = find.text('Waitlist');

    expect(waitlistButton, findsOneWidget);

    await widgetTester.tap(waitlistButton);
    await widgetTester.pumpAndSettle();

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

    await widgetTester.tap(find.byType(BackButton));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.text('Search'));
    await widgetTester.pumpAndSettle();
  });
}
