import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
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

    return SafeArea(
      child: Wrap(
        children: [
          ListTile(
            title: Text(
              'All',
              style: context.textStyles.titleMedium,
            ),
            subtitle: Text(
              'Select all games',
              style: context.textStyles.bodySmall,
            ),
            onTap: () async {
              return ref
                  .watch(steamImportProvider.notifier)
                  .set(steamImportState.deals ?? []);
            },
          ),
          ListTile(
            title: Text(
              'None',
              style: context.textStyles.titleMedium,
            ),
            subtitle: Text(
              'De-select all games',
              style: context.textStyles.bodySmall,
            ),
            onTap: () async {
              return ref.watch(steamImportProvider.notifier).set([]);
            },
          ),
        ],
      ),
    );
  }
}
