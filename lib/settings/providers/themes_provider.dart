import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/models/observatory_theme.dart';

class ThemesProvider extends Notifier<ObservatoryTheme> {
  @override
  ObservatoryTheme build() {
    return GetIt.I<SettingsRepository>().getTheme();
  }

  Future<void> setThemeMode(String mode) async {
    final ObservatoryTheme theme = state.copyWith(
      mode: mode,
    );

    await GetIt.I<SettingsRepository>().setTheme(theme);

    state = theme;
  }

  Future<void> setScheme(FlexScheme scheme) async {
    final ObservatoryTheme theme = state.copyWith(
      scheme: scheme.name,
    );

    await GetIt.I<SettingsRepository>().setTheme(theme);

    state = theme;
  }

  Future<void> setTrueBlack(bool isTrueBlack) async {
    final ObservatoryTheme theme = state.copyWith(
      isTrueBlack: isTrueBlack,
    );

    await GetIt.I<SettingsRepository>().setTheme(theme);

    state = theme;
  }
}

final themesProvider = NotifierProvider<ThemesProvider, ObservatoryTheme>(() {
  return ThemesProvider();
});
