import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:observatory/auth/providers/itad_provider.dart';
import 'package:observatory/router.dart';
import 'package:observatory/settings/providers/themes_provider.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/auth/providers/steam_provider.dart';
import 'package:observatory/shared/api/api.dart';
import 'package:observatory/shared/models/observatory_theme.dart';
import 'package:observatory/shared/ui/theme.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> initSettings() async {
  await SettingsRepository.init();

  GetIt.I.registerSingleton<SettingsRepository>(SettingsRepository());
  GetIt.I.registerSingleton<API>(API());
}

class Observatory extends ConsumerStatefulWidget {
  const Observatory({
    super.key,
  });

  @override
  ConsumerState<Observatory> createState() => _ObservatoryState();
}

class _ObservatoryState extends ConsumerState<Observatory> {
  StreamSubscription? _linkSubscription;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();

      GetIt.I<SettingsRepository>().incrementLaunchCounter();
    });

    _linkSubscription = AppLinks().uriLinkStream.listen(
      (uri) async {
        if (uri.path == '/app/auth/steam') {
          await ref.read(steamProvider.notifier).handleRedirect(uri);
          await ref.read(steamProvider.notifier).importData();
        }

        if (uri.path == '/app/auth/itad') {
          await ref.watch(itadProvider.notifier).handleRedirect(uri);
          await ref.watch(itadProvider.notifier).importData();
        }
      },
      onError: (error) {
        Sentry.captureException(
          error,
          stackTrace: StackTrace.current,
        );
      },
    );
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
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
      },
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: 'secrets.env');

  await SentryFlutter.init(
    (options) {
      options.dsn = dotenv.maybeGet('SENTRY_DSN') ?? '';
      options.enableAutoSessionTracking = false;
      options.enableAutoPerformanceTracing = false;
    },
    appRunner: () async {
      await initSettings();

      return runApp(
        const ProviderScope(
          child: Observatory(),
        ),
      );
    },
  );
}
