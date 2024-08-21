import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/settings/providers/settings_provider.dart';

class CollapsePinnedListTile extends ConsumerWidget {
  const CollapsePinnedListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool collapse = ref.watch(
      asyncSettingsProvider.select(
        (value) => value.valueOrNull?.collapsePinned ?? false,
      ),
    );

    return SwitchListTile(
      title: const Text('Group Pinned'),
      subtitle: const Text(
        'Collapse pinned games into a separate category.',
      ),
      value: collapse,
      onChanged: (value) {
        ref.read(asyncSettingsProvider.notifier).setCollapsePinned(value);
      },
    );
  }
}
