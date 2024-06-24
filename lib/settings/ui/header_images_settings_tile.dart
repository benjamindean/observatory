import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/settings/providers/settings_provider.dart';

class HeaderImagesSettingsTile extends ConsumerWidget {
  const HeaderImagesSettingsTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isEnabled = ref.watch(
      asyncSettingsProvider.select(
        (value) => value.valueOrNull?.showHeaders ?? true,
      ),
    );

    return SwitchListTile(
      value: isEnabled,
      title: const Text('Display Header Images'),
      subtitle: const Text('Display images above deal cards.'),
      onChanged: (value) {
        ref.read(asyncSettingsProvider.notifier).setShowHeaders(value);
      },
    );
  }
}
