import 'package:app_links/app_links.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:observatory/auth/providers/itad_provider.dart';
import 'package:observatory/notifications/constants.dart';
import 'package:observatory/router.dart';
import 'package:observatory/secret_loader.dart';
import 'package:observatory/settings/providers/themes_provider.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/auth/providers/steam_provider.dart';
import 'package:observatory/shared/api/api.dart';
import 'package:observatory/shared/models/observatory_theme.dart';
import 'package:observatory/shared/ui/observatory_dialog.dart';
import 'package:observatory/shared/ui/theme.dart';
import 'package:observatory/tasks/check_waitlist.dart';
import 'package:observatory/tasks/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:workmanager/workmanager.dart';

Future<void> initSettings() async {
  await SettingsRepository.init();

  final String cache = (await getApplicationDocumentsDirectory()).path;

  GetIt.I.registerSingleton<Secret>(await SecretLoader.load());
  GetIt.I.registerSingleton<SettingsRepository>(SettingsRepository());
  GetIt.I.registerSingleton<API>(API.create(cache));
}

Future<void> initSupabase() async {
  await Supabase.initialize(
    url: GetIt.I<Secret>().supabaseUrl,
    anonKey: GetIt.I<Secret>().supabaseAnonKey,
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

    GetIt.I<SettingsRepository>().getLaunchCounter().then((value) {
      if (value % 5 == 0) {
        if (context.mounted) {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return ObservatoryDialog(
                onApply: () {
                  context.push('/observatory-plus');
                },
                onDiscard: () {
                  context.pop();
                },
                title: 'Support Observatory',
                body:
                    'This app is free and ad-free, and I intend to keep it that way for the foreseeable future. If you enjoy the app, please consider supporting it.',
                discardText: 'Not Now',
                applyText: 'Support',
              );
            },
          );
        }
      }
    });

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
      options.dsn = kDebugMode ? '' : GetIt.I<Secret>().sentryDsn;
    },
    appRunner: () => runApp(
      const ProviderScope(
        child: Observatory(),
      ),
    ),
  );
}
