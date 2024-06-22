import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/settings/providers/settings_provider.dart';

class HeaderImagesSettingsTile extends ConsumerWidget {
  final bool isEnabled;

  const HeaderImagesSettingsTile({
    super.key,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
