import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/itad_filters/providers/itad_filters_provider.dart';
import 'package:observatory/main.dart';
import 'package:observatory/search/providers/search_provider.dart';
import 'package:observatory/waitlist/providers/waitlist_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/api/api.dart';

import './mocks/waitlist_mocks.dart';
import './mocks/search_mocks.dart';
import './mocks/itad_filters_mocks.dart';

void main() async {
  WidgetsApp.debugAllowBannerOverride = false;

  enableFlutterDriverExtension(enableTextEntryEmulation: false);

  await SettingsRepository.init();

  GetIt.I.registerSingleton<API>(API());

  await GetIt.I<SettingsRepository>().setITADFilters(filtersMock);

  runApp(
    ProviderScope(
      overrides: [
        asyncWaitListProvider.overrideWith(AsyncWaitListNotifierMock.new),
        itadFiltersProvider.overrideWith(ITADFiltersNotifierMock.new),
        searchProvider.overrideWithProvider(
          (type) {
            if (type == SearchType.search) {
              return dealSearchProviderMock;
            }

            return waitlistSearchProvider;
          },
        ),
      ],
      child: const Observatory(),
    ),
  );
}
