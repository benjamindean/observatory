import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/settings/providers/settings_provider.dart';

class MuteGamesInLibraryListTile extends ConsumerWidget {
  const MuteGamesInLibraryListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool mute = ref.watch(
      asyncSettingsProvider.select(
        (value) => value.valueOrNull?.muteGamesInLibrary ?? false,
      ),
    );

    return SwitchListTile(
      title: const Text('Mute Owned Games'),
      subtitle: const Text(
        'Display owned games as slightly muted in the deals list.',
      ),
      value: mute,
      onChanged: (value) {
        ref.read(asyncSettingsProvider.notifier).setMuteGamesInLibrary(value);
      },
    );
  }
}
