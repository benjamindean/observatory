import 'package:app_links/app_links.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:observatory/auth/providers/itad_provider.dart';
import 'package:observatory/notifications/constants.dart';
import 'package:observatory/router.dart';
import 'package:observatory/settings/providers/themes_provider.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/auth/providers/steam_provider.dart';
import 'package:observatory/shared/api/api.dart';
import 'package:observatory/shared/models/observatory_theme.dart';
import 'package:observatory/shared/ui/theme.dart';
import 'package:observatory/tasks/check_waitlist.dart';
import 'package:observatory/tasks/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:workmanager/workmanager.dart';

Future<void> initSettings() async {
  await dotenv.load(fileName: 'secrets.env');
  await SettingsRepository.init();

  final String cache = (await getApplicationDocumentsDirectory()).path;

  GetIt.I.registerSingleton<SettingsRepository>(SettingsRepository());
  GetIt.I.registerSingleton<API>(API.create(cache));
}

Future<void> initSupabase() async {
  await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('SUPABASE_ANON_KEY'),
    authOptions: const FlutterAuthClientOptions(
      detectSessionInUri: false,
    ),
  );
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == TASK_CHECK_WAITLIST) {
      await initSettings();

      return await checkWaitlistTask();
    }

    return false;
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

    AppLinks().uriLinkStream.listen(
      (uri) async {
        if (uri.path == '/app/auth/steam') {
          await ref.read(steamProvider.notifier).handleRedirect(uri);
          await ref.read(steamProvider.notifier).import();
        }

        if (uri.path == '/app/auth/itad') {
          await ref.watch(itadProvider.notifier).handleRedirect(uri);
          await ref.watch(itadProvider.notifier).import();
        }
      },
      onError: (error) {
        Sentry.captureException(
          error,
          stackTrace: StackTrace.current,
        );
      },
    );

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
    isInDebugMode: kDebugMode,
  );

  // Re-enable check waitlist task if notifications are enabled
  if (await GetIt.I<SettingsRepository>().getWaitlistNotifications()) {
    await disableCheckWaitlistTask();
    await enableCheckWaitlistTask();
  }

  GetIt.I<SettingsRepository>().incrementLaunchCounter();

  await SentryFlutter.init(
    (options) {
      options.dsn = kDebugMode ? '' : dotenv.get('SENTRY_DSN');
      options.autoInitializeNativeSdk = false;
    },
    appRunner: () => runApp(
      const ProviderScope(
        child: Observatory(),
      ),
    ),
  );
}
