import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:observatory/settings/steam_import/steam_import_provider.dart';
import 'package:observatory/settings/steam_import/steam_import_state.dart';

class SteamImportListTile extends ConsumerWidget {
  const SteamImportListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SteamImportState steamImportState = ref.watch(
      steamImportProvider,
    );

    final String steamUserName =
        steamImportState.usernameInputController.value.text;
    final bool isImporting =
        steamImportState.isImporting || steamImportState.isLoading;

    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(16, 0, 12, 0),
      title: steamUserName.isEmpty
          ? Text(
              'No Steam Username set',
              style: context.textStyles.titleMedium.copyWith(
                color: context.colors.disabled,
              ),
            )
          : Text(steamUserName),
      trailing: TextButton.icon(
        icon: isImporting
            ? Transform.scale(
                scale: 0.4,
                child: const CircularProgressIndicator(),
              )
            : null,
        onPressed: isImporting
            ? null
            : () {
                try {
                  if (steamUserName.isEmpty) {
                    context.push('/steam-import');
                  } else {
                    ref
                        .watch(steamImportProvider.notifier)
                        .reImport()
                        .whenComplete(() => context.pop());
                  }
                } catch (error, stackTrace) {
                  Logger().w(
                    'Failed to import Steam wishlist',
                    error: error,
                    stackTrace: stackTrace,
                  );

                  FirebaseCrashlytics.instance.recordError(
                    error,
                    stackTrace,
                  );

                  context.pop();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Icon(
                              Icons.error,
                              color: context
                                  .themes.snackBar.contentTextStyle!.color,
                            ),
                          ),
                          const Expanded(
                            child: Text(
                              'There was an error importing your wishlist. Please check if your Steam profile is public and try again.',
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
              },
        label: steamUserName.isNotEmpty
            ? const Text('Re-Import')
            : const Text('Set Username'),
      ),
    );
  }
}
