import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/settings/settings_provider.dart';
import 'package:observatory/shared/models/observatory_theme.dart';

class ThemeTrueBlackListTile extends ConsumerWidget {
  const ThemeTrueBlackListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ObservatoryTheme theme = ref.watch(themeModeProvider);
    final bool isLightTheme =
        MediaQuery.of(context).platformBrightness != Brightness.dark &&
            theme.mode != 'dark';

    return SwitchListTile(
      value: theme.isTrueBlack,
      title: const Text('Use True Black'),
      subtitle: const Text('Use true black for dark mode.'),
      onChanged: isLightTheme
          ? null
          : (value) {
              ref.watch(themeModeProvider.notifier).setTheme(
                    ObservatoryTheme(
                      mode: theme.mode,
                      isTrueBlack: value,
                    ),
                  );
            },
    );
  }
}
