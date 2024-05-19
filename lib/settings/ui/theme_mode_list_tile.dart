import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/settings/settings_provider.dart';
import 'package:observatory/shared/models/observatory_theme.dart';

final List<ThemeMode> themeModes = [
  ThemeMode.dark,
  ThemeMode.light,
  ThemeMode.system
];

class ThemeModeListTile extends ConsumerWidget {
  const ThemeModeListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ObservatoryTheme theme = ref.watch(themesProvider);

    return ListTile(
      title: const Text('Theme Mode'),
      subtitle: const Text('Dark, Light or Auto.'),
      trailing: ToggleButtons(
        direction: Axis.horizontal,
        onPressed: (int index) {
          ref
              .watch(themesProvider.notifier)
              .setThemeMode(themeModes[index].name);
        },
        isSelected: themeModes.map(
          (e) {
            return e == ThemeMode.values.asNameMap()[theme.mode];
          },
        ).toList(),
        children: const [
          Icon(
            Icons.brightness_4,
            key: Key('theme_togge_dark'),
          ),
          Icon(
            Icons.brightness_7,
            key: Key('theme_togge_light'),
          ),
          Icon(
            Icons.brightness_auto,
            key: Key('theme_togge_auto'),
          ),
        ],
      ),
    );
  }
}
