import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:observatory/firebase_options.dart';
import 'package:observatory/router.dart';
import 'package:observatory/secret_loader.dart';
import 'package:observatory/settings/settings_provider.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/api/api.dart';
import 'package:observatory/shared/models/observatory_theme.dart';
import 'package:observatory/shared/ui/theme.dart';
import 'package:uni_links/uni_links.dart';

final state = GlobalKey<ScaffoldMessengerState>();

class Observatory extends ConsumerWidget {
  const Observatory({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ObservatoryTheme theme = ref.watch(themeModeProvider);

    return MaterialApp.router(
      scaffoldMessengerKey: state,
      title: 'Observatory',
      theme: lightTheme,
      darkTheme: darkTheme(darkIsTrueBlack: theme.isTrueBlack),
      themeMode: ThemeMode.values.asNameMap()[theme.mode],
      routerConfig: router,
    );
  }
}

Future<void> initUniLinks() async {
  try {
    final String? initialLink = await getInitialLink();

    if (initialLink == null) {
      return;
    }
  } on PlatformException {
    return;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SettingsRepository.init();

  GetIt.I.registerSingleton<SettingsRepository>(SettingsRepository());
  GetIt.I.registerSingleton<API>(await API.create());
  GetIt.I.registerSingleton<Secret>(await SecretLoader.load());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // (value) => GetIt.I.registerSingleton<FirebaseFirestore>(
  //   FirebaseFirestore.instance,
  // ),

  await FirebaseAppCheck.instance.activate();

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);

    return true;
  };

  runApp(
    const ProviderScope(
      child: Observatory(),
    ),
  );
}
