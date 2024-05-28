import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/settings/steam_import/steam_import_provider.dart';
import 'package:observatory/settings/steam_import/steam_import_state.dart';
import 'package:observatory/settings/steam_import/ui/steam_import_filter.dart';
import 'package:observatory/settings/steam_import/ui/steam_import_form.dart';
import 'package:observatory/settings/steam_import/ui/unfinished_import_dialog.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/ui/observatory_back_button.dart';
import 'package:observatory/shared/widgets/error_message.dart';
import 'package:observatory/shared/widgets/progress_indicator.dart';

class SteamImportPage extends ConsumerWidget {
  const SteamImportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SteamImportState steamImportState = ref.watch(steamImportProvider);

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Expanded(
                  flex: 50,
                  child: ObservatoryBackButton(),
                ),
                Expanded(
                  flex: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: IconButton(
                          onPressed: steamImportState.deals == null
                              ? null
                              : () {
                                  showModalBottomSheet(
                                    useSafeArea: true,
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) {
                                      return const SteamImportFilter();
                                    },
                                  );
                                },
                          icon: const Icon(Icons.filter_list),
                        ),
                      ),
                      FilledButton.icon(
                        onPressed: steamImportState.selectedDeals.isEmpty ||
                                steamImportState.isImporting ||
                                steamImportState.isImporting
                            ? null
                            : () async {
                                ref
                                    .read(steamImportProvider.notifier)
                                    .import()
                                    .then(
                                  (result) {
                                    if (result == null) {
                                      return;
                                    }

                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: ImportSuccessSnackBarContent(
                                          count: result.length.toString(),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                        icon: steamImportState.isImporting
                            ? const ObservatoryIconProgressIndicator()
                            : const Icon(Icons.import_export_rounded),
                        label: const Text('Import'),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
      appBar: steamImportState.deals?.isNotEmpty != null
          ? AppBar(
              title: const Text('Import Wishlist from Steam'),
            )
          : null,
      body: Column(
        children: [
          PopScope(
            canPop: (steamImportState.deals ?? []).isEmpty ||
                steamImportState.isImporting,
            onPopInvoked: (canPop) {
              if (canPop) {
                return;
              }

              showAdaptiveDialog<void>(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return const UnfinishedImportDialog();
                },
              );
            },
            child: Expanded(
              child: Builder(
                builder: (BuildContext context) {
                  if (steamImportState.error != null) {
                    return ErrorMessage(
                      message: steamImportState.error,
                      helper: TextButton(
                        onPressed: () {
                          ref.read(steamImportProvider.notifier).reset();
                        },
                        child: const Text('Try Again'),
                      ),
                    );
                  }

                  if (steamImportState.deals == null) {
                    return const SteamImportForm();
                  }

                  if ((steamImportState.deals ?? []).isEmpty &&
                      !steamImportState.isLoading) {
                    return ErrorMessage(
                      message: 'Nothing found',
                      helper: TextButton(
                        onPressed: () {
                          ref.read(steamImportProvider.notifier).reset();
                        },
                        child: const Text('Try Again'),
                      ),
                    );
                  }

                  final List<Deal> importDeals = steamImportState.deals ?? [];

                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: importDeals.length,
                          itemBuilder: (context, index) {
                            final Deal deal = importDeals[index];

                            return CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              title: Text(deal.title),
                              value: steamImportState.selectedDeals.contains(
                                deal,
                              ),
                              onChanged: (value) async {
                                if (value != null) {
                                  return ref
                                      .read(steamImportProvider.notifier)
                                      .toggle(deal, value);
                                }
                              },
                            );
                          },
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImportSuccessSnackBarContent extends StatelessWidget {
  final String count;

  const ImportSuccessSnackBarContent({
    super.key,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: context.themes.snackBar.contentTextStyle,
        children: [
          const TextSpan(text: 'Successfully imported '),
          TextSpan(
            text: count,
            style: context.themes.snackBar.contentTextStyle?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const TextSpan(text: ' games to your waitlist!'),
        ],
      ),
    );
  }
}
