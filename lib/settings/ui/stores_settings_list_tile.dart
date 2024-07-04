import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:observatory/settings/providers/itad_config_provider.dart';
import 'package:observatory/shared/models/store.dart';

class StoresSettingsListTile extends ConsumerWidget {
  const StoresSettingsListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Store> stores = ref.watch(
      itadConfigProvider.select((config) => config.valueOrNull?.stores ?? []),
    );
    final List<int> selectedStores = ref.watch(
      itadConfigProvider.select(
        (config) => config.valueOrNull?.selectedStores ?? [],
      ),
    );

    return ListTile(
      title: const Text('Stores'),
      subtitle: const Text('Choose stores to retrieve prices from.'),
      trailing: OutlinedButton.icon(
        icon: const Icon(Icons.arrow_drop_down_circle),
        label: Text(
          '${selectedStores.length.toString()} of ${stores.length.toString()}',
        ),
        onPressed: () {
          context.push('/store-select');
        },
      ),
    );
  }
}
