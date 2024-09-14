import 'package:app_links/app_links.dart';
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
import 'package:observatory/settings/steam_import/steam_import_provider.dart';
import 'package:observatory/shared/api/api.dart';
import 'package:observatory/shared/helpers/steam_openid.dart';
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

    AppLinks().uriLinkStream.listen(
      (uri) async {
        await GetIt.I<SettingsRepository>().setSteamUsername(
          uri.path.toString(),
        );

        if (uri.path == '/app/auth/steam') {
          OpenId openId = const OpenId();

          final String steamId = await openId.validate(
            uri.queryParameters,
          );

          await GetIt.I<SettingsRepository>().setSteamUsername(steamId);

          await ref.read(steamImportProvider.notifier).fetch();
          await ref.read(steamImportProvider.notifier).import();
        }
      },
      onError: (error) {
        FirebaseCrashlytics.instance.recordError(
          error,
          StackTrace.current,
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

  const OpenId openId = OpenId();

  await openId.validate(
    Uri.parse(
            'https://getobservatory.app/app/auth/steam?openid.ns=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0&openid.mode=id_res&openid.op_endpoint=https%3A%2F%2Fsteamcommunity.com%2Fopenid%2Flogin&openid.claimed_id=https%3A%2F%2Fsteamcommunity.com%2Fopenid%2Fid%2F76561198116454515&openid.identity=https%3A%2F%2Fsteamcommunity.com%2Fopenid%2Fid%2F76561198116454515&openid.return_to=https%3A%2F%2Fgetobservatory.app%2Fapp%2Fauth%2Fsteam&openid.response_nonce=2024-09-14T15%3A26%3A15ZiftiZaLtHJV0jf8Rw1vy0qdGPPY%3D&openid.assoc_handle=1234567890&openid.signed=signed%2Cop_endpoint%2Cclaimed_id%2Cidentity%2Creturn_to%2Cresponse_nonce%2Cassoc_handle&openid.sig=1e6Ymtm5qksrVu6j9CSFuzgDhXc%3D')
        .queryParameters,
  );

  runApp(
    const ProviderScope(
      child: Observatory(),
    ),
  );
}
