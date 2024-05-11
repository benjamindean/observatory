import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:observatory/settings/steam_import/steam_import_provider.dart';
import 'package:observatory/shared/ui/observatory_dialog.dart';

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
        context.pop();
        context.pop();
      },
      onApply: () async {
        ref.read(steamImportProvider.notifier).import().then(
          (result) {
            context.pop();

            if (result == null) {
              return;
            }

            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: RichText(
                  text: TextSpan(
                    style: context.themes.snackBar.contentTextStyle,
                    children: [
                      const TextSpan(text: 'Successfully imported '),
                      TextSpan(
                        text: result.length.toString(),
                        style:
                            context.themes.snackBar.contentTextStyle!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(text: ' games to your waitlist!'),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
