import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/settings/settings_provider.dart';
import 'package:observatory/settings/settings_repository.dart';

class DealCardTypeSettingsTile extends ConsumerWidget {
  const DealCardTypeSettingsTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DealCardType dealCardType = ref.watch(
      asyncSettingsProvider.select(
        (value) => value.value?.dealCardType ?? DealCardType.expanded,
      ),
    );

    return ListTile(
      title: const Text('Deal Card'),
      subtitle: const Text('Full or Compact.'),
      trailing: ToggleButtons(
        direction: Axis.horizontal,
        onPressed: (int index) {
          ref
              .read(asyncSettingsProvider.notifier)
              .setDealCardType(DealCardType.values[index]);
        },
        isSelected: DealCardType.values.map((e) => e == dealCardType).toList(),
        children: const [
          Icon(Icons.view_comfortable),
          Icon(Icons.view_compact)
        ],
      ),
    );
  }
}
