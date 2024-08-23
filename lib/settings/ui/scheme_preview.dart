import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/settings/providers/themes_provider.dart';
import 'package:observatory/shared/ui/theme.dart';

class SchemePreview extends ConsumerWidget {
  final FlexScheme scheme;

  const SchemePreview({
    super.key,
    required this.scheme,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? schemeName = ref.watch(
      themesProvider.select((value) => value.scheme),
    );

    final ThemeData themeData =
        MediaQuery.of(context).platformBrightness == Brightness.light
            ? lightTheme(scheme: scheme)
            : darkTheme(scheme: scheme);

    return FlexThemeModeOptionButton(
      flexSchemeColor: FlexSchemeColor.from(
        primary: themeData.colorScheme.primary,
        primaryContainer: themeData.colorScheme.primaryContainer,
        secondary: themeData.colorScheme.secondary,
        secondaryContainer: themeData.colorScheme.secondaryContainer,
        tertiary: themeData.colorScheme.tertiary,
        tertiaryContainer: themeData.colorScheme.tertiaryContainer,
      ),
      selected: schemeName == scheme.name,
      onSelect: () {
        ref.read(themesProvider.notifier).setScheme(scheme);
      },
    );
  }
}
