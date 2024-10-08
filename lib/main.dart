import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:observatory/firebase_options.dart';
import 'package:observatory/notifications/constants.dart';
import 'package:observatory/router.dart';
import 'package:observatory/secret_loader.dart';
import 'package:observatory/settings/providers/themes_provider.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/api/api.dart';
import 'package:observatory/shared/models/observatory_theme.dart';
import 'package:observatory/shared/ui/theme.dart';
import 'package:observatory/tasks/check_waitlist.dart';
import 'package:observatory/tasks/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:workmanager/workmanager.dart';

Future<void> initSettings() async {
  await SettingsRepository.init();

  final String cache = (await getApplicationDocumentsDirectory()).path;

  GetIt.I.registerSingleton<SettingsRepository>(SettingsRepository());
  GetIt.I.registerSingleton<API>(API.create(cache));
  GetIt.I.registerSingleton<Secret>(await SecretLoader.load());
}

Future<void> initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAppCheck.instance.activate();

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);

    return true;
  };
}

Future<void> initSupabase() async {
  await Supabase.initialize(
    url: GetIt.I<Secret>().supabaseUrl,
    anonKey: GetIt.I<Secret>().supabaseAnonKey,
  );
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      if (task == TASK_CHECK_WAITLIST) {
        await initSettings();
        await initFirebase();

        return await checkWaitlistTask();
      }

      return false;
    } catch (error, stackTrace) {
      FirebaseCrashlytics.instance.recordError(error, stackTrace);

      return false;
    }
  });
}

@pragma('vm:entry-point')
Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
  if (rootNavigatorKey.currentContext != null) {
    GoRouter.of(rootNavigatorKey.currentContext!).go('/waitlist');
  }
}

class Observatory extends ConsumerWidget {
  const Observatory({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ObservatoryTheme theme = ref.watch(themesProvider);

    return MaterialApp.router(
      title: 'Observatory',
      theme: lightTheme(
        scheme: theme.flexScheme,
      ),
      darkTheme: darkTheme(
        darkIsTrueBlack: theme.isTrueBlack,
        scheme: theme.flexScheme,
      ),
      themeMode: ThemeMode.values.asNameMap()[theme.mode],
      routerConfig: router,
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initSettings();
  await initFirebase();
  await initSupabase();

  await AwesomeNotifications().initialize(
    null,
    NOTIFICATION_CHANNELS,
    channelGroups: NOTIFICATION_GROUPS,
  );

  await AwesomeNotifications().setListeners(
    onActionReceivedMethod: onActionReceivedMethod,
  );

  await Workmanager().initialize(
    callbackDispatcher,
  );

  // Re-enable check waitlist task if notifications are enabled
  if (await GetIt.I<SettingsRepository>().getWaitlistNotifications()) {
    await disableCheckWaitlistTask();
    await enableCheckWaitlistTask();
  }

  GetIt.I<SettingsRepository>().incrementLaunchCounter();

  runApp(
    const ProviderScope(
      child: Observatory(),
    ),
  );
}
