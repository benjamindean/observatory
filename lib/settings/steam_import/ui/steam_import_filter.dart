import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/settings/steam_import/steam_import_provider.dart';
import 'package:observatory/settings/steam_import/steam_import_state.dart';

class SteamImportFilter extends ConsumerWidget {
  const SteamImportFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SteamImportState steamImportState = ref.watch(steamImportProvider);

    return Wrap(
      children: [
        ListTile(
          title: const Text('All'),
          onTap: () async {
            return ref
                .watch(steamImportProvider.notifier)
                .set(steamImportState.deals!);
          },
        ),
        ListTile(
          title: const Text('None'),
          onTap: () async {
            return ref.watch(steamImportProvider.notifier).set([]);
          },
        )
      ],
    );
  }
}
