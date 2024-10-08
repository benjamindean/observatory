import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/itad_filters/providers/itad_filters_provider.dart';
import 'package:observatory/main.dart';
import 'package:observatory/search/providers/search_provider.dart';
import 'package:observatory/waitlist/providers/waitlist_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:observatory/secret_loader.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/api/api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import './mocks/waitlist_mocks.dart';
import './mocks/search_mocks.dart';
import './mocks/itad_filters_mocks.dart';

void main() async {
  WidgetsApp.debugAllowBannerOverride = false;

  enableFlutterDriverExtension(enableTextEntryEmulation: false);

  await SettingsRepository.init();

  final String cache = (await getApplicationDocumentsDirectory()).path;

  GetIt.I.registerSingleton<SettingsRepository>(SettingsRepository());
  GetIt.I.registerSingleton<API>(API.create(cache));
  GetIt.I.registerSingleton<Secret>(await SecretLoader.load());

  await Supabase.initialize(
    url: GetIt.I<Secret>().supabaseUrl,
    anonKey: GetIt.I<Secret>().supabaseAnonKey,
  );

  await GetIt.I<SettingsRepository>().setITADFilters(filtersMock);

  runApp(
    ProviderScope(
      overrides: [
        asyncWaitListProvider.overrideWith(AsyncWaitListNotifierMock.new),
        itadFiltersProvider.overrideWith(ITADFiltersNotifierMock.new),
        searchProvider.overrideWithProvider(
          (type) {
            if (type == SearchType.search) {
              return searchResultsProviderMock;
            }

            return filterResultsProvider;
          },
        ),
      ],
      child: const Observatory(),
    ),
  );
}
