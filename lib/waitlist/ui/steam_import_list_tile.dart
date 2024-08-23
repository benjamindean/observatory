import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:observatory/settings/steam_import/steam_import_provider.dart';
import 'package:observatory/settings/steam_import/steam_import_state.dart';
import 'package:observatory/shared/ui/observatory_snack_bar.dart';
import 'package:observatory/shared/widgets/progress_indicator.dart';

class SteamImportListTile extends ConsumerWidget {
  const SteamImportListTile({
    super.key,
  });

  Widget getIcon(String? steamUserName, bool isImporting) {
    if (isImporting) {
      return const ObservatoryIconProgressIndicator();
    }

    if (steamUserName?.isEmpty != false) {
      return const Icon(Icons.person_add);
    }

    return const Icon(Icons.refresh);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SteamImportState steamImportState = ref.watch(
      steamImportProvider,
    );

    final String? steamUserName = steamImportState.username;
    final bool isImporting =
        steamImportState.isImporting || steamImportState.isLoading;

    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(16, 0, 12, 0),
      title: const Text('Steam Import'),
      subtitle: steamUserName?.isEmpty != false
          ? Text(
              'No Steam username set',
              style: context.textStyles.titleMedium.copyWith(
                color: context.colors.disabled,
              ),
            )
          : Text(steamUserName ?? 'None'),
      trailing: TextButton.icon(
        icon: getIcon(steamUserName, isImporting),
        onPressed: isImporting
            ? null
            : () {
                try {
                  if (steamUserName?.isEmpty != false) {
                    context.push('/steam-import');
                  } else {
                    ref
                        .watch(steamImportProvider.notifier)
                        .reImport()
                        .whenComplete(() {
                      if (context.mounted) {
                        context.pop();
                      }
                    });
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

                  return ObservatorySnackBar.show(
                    context,
                    icon: Icons.error,
                    content: Text(
                      'There was an error importing your wishlist. Please check if your Steam profile is public and try again.',
                      style: context.themes.snackBar.contentTextStyle?.copyWith(
                        color: context.colors.scheme.onInverseSurface,
                      ),
                    ),
                  );
                }
              },
        label: steamUserName?.isNotEmpty == true
            ? const Text('Re-Import')
            : const Text('Set Username'),
      ),
    );
  }
}
