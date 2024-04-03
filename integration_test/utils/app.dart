import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
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

import '../mocks/deals_mocks.dart';
import '../mocks/waitlist_mocks.dart';

Future<void> initDependencies() async {
  await SettingsRepository.init();

  GetIt.I.registerSingleton<SettingsRepository>(SettingsRepository());
  GetIt.I.registerSingleton<API>(await API.create());
  GetIt.I.registerSingleton<Secret>(await SecretLoader.load());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAppCheck.instance.activate();
}

Future<void> runObservatory(WidgetTester widgetTester) async {
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
}
