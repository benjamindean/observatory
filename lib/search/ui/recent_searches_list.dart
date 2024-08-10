import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:observatory/search/providers/search_provider.dart';
import 'package:observatory/shared/ui/observatory_card.dart';
import 'package:observatory/shared/ui/observatory_dialog.dart';
import 'package:observatory/shared/ui/ory_full_screen_spinner.dart';
import 'package:observatory/shared/widgets/error_message.dart';

class RecentSearchesList extends ConsumerWidget {
  const RecentSearchesList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<String>> recents = ref.watch(asynRecentsProvider);

    return recents.when(
      data: (data) {
        if (data.isEmpty) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: ErrorMessage(
                message: 'You haven\'t searched for anything yet.',
                icon: Icons.search_off_outlined,
                helper: TextButton(
                  onPressed: () {
                    ref.read(searchResultsProvider.notifier).setIsOpen();
                  },
                  child: const Text('Search Now'),
                ),
              ),
            ),
          );
        }

        final List<String> recentsList = data.toList();

        return SliverPadding(
          padding: const EdgeInsets.all(6.0),
          sliver: SliverList.builder(
            itemBuilder: (context, index) {
              if (index == recentsList.length) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: TextButton.icon(
                      icon: const Icon(Icons.cancel_rounded),
                      onPressed: () {
                        showAdaptiveDialog(
                          context: context,
                          builder: (context) {
                            return ObservatoryDialog(
                              onApply: () {
                                ref
                                    .read(asynRecentsProvider.notifier)
                                    .clearRecents()
                                    .then(
                                  (value) {
                                    if (context.mounted) {
                                      context.pop();
                                    }
                                  },
                                );
                              },
                              onDiscard: () {
                                context.pop();
                              },
                              title: 'Clear all recent searches?',
                              body: 'This operation cannot be undone.',
                              discardText: 'Cancel',
                              applyText: 'Clear',
                            );
                          },
                        );
                      },
                      label: const Text('Clear All'),
                    ),
                  ),
                );
              }

              return ObservatoryCard(
                child: InkWell(
                  onTap: () async {
                    await ref
                        .read(searchResultsProvider.notifier)
                        .performSearch(recentsList[index]);
                  },
                  child: ListTile(
                    contentPadding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                    trailing: IconButton(
                      icon: const Icon(Icons.cancel),
                      onPressed: () {
                        ref.read(asynRecentsProvider.notifier).removeRecent(
                              recentsList[index],
                            );
                      },
                    ),
                    title: Text(recentsList[index]),
                  ),
                ),
              );
            },
            itemCount: recentsList.length + 1,
          ),
        );
      },
      error: (error, stackTrace) {
        Logger().e(
          'Failed to load recent searches',
          error: error,
          stackTrace: stackTrace,
        );

        FirebaseCrashlytics.instance.recordError(
          error,
          stackTrace,
        );

        return const SliverFillRemaining(
          hasScrollBody: false,
          child: ErrorMessage(
            icon: FontAwesomeIcons.solidFaceDizzy,
            message: 'Failed to load recents.',
          ),
        );
      },
      loading: () {
        return const OryFullScreenSpinner();
      },
    );
  }
}
