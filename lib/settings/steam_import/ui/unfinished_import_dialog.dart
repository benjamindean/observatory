import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:observatory/settings/steam_import/steam_import_provider.dart';
import 'package:observatory/shared/ui/observatory_dialog.dart';
import 'package:observatory/shared/ui/observatory_snack_bar.dart';

class UnfinishedImportDialog extends ConsumerWidget {
  const UnfinishedImportDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ObservatoryDialog(
      title: 'Unfinished Import',
      body:
          'It seems like your import process is unfinished. What would you like to do?',
      applyText: 'Import',
      discardText: 'Abort',
      onDiscard: () {
        ref.read(steamImportProvider.notifier).reset();

        context.pop();
      },
      onApply: () async {
        ref.read(steamImportProvider.notifier).import().then(
          (result) {
            if (context.mounted) {
              context.pop();

              if (result == null) {
                return;
              }

              return ObservatorySnackBar.show(
                context,
                content: RichText(
                  text: TextSpan(
                    style: context.themes.snackBar.contentTextStyle?.copyWith(
                      color: context.colors.scheme.onInverseSurface,
                    ),
                    children: [
                      TextSpan(
                        text: 'Successfully imported ',
                        style:
                            context.themes.snackBar.contentTextStyle?.copyWith(
                          color: context.colors.scheme.onInverseSurface,
                        ),
                      ),
                      TextSpan(
                        text: result.length.toString(),
                        style:
                            context.themes.snackBar.contentTextStyle?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colors.scheme.onInverseSurface,
                        ),
                      ),
                      TextSpan(
                        text: ' games to your waitlist!',
                        style:
                            context.themes.snackBar.contentTextStyle?.copyWith(
                          color: context.colors.scheme.onInverseSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
