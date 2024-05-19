import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/settings/settings_provider.dart';
import 'package:observatory/shared/models/observatory_theme.dart';
import 'package:observatory/shared/ui/theme.dart';

class SchemePreview extends ConsumerWidget {
  final FlexScheme scheme;

  const SchemePreview({
    super.key,
    required this.scheme,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ObservatoryTheme theme = ref.watch(themesProvider);

    final ThemeData themeData = theme.mode == 'dark'
        ? darkTheme(
            scheme: scheme,
          )
        : lightTheme(
            scheme: scheme,
          );

    return FlexThemeModeOptionButton(
      flexSchemeColor: FlexSchemeColor.from(
        primary: themeData.colorScheme.primary,
        secondary: themeData.colorScheme.secondary,
      ),
      selected: theme.scheme == scheme.name,
      onSelect: () {
        ref.read(themesProvider.notifier).setScheme(scheme);
      },
    );
  }
}
