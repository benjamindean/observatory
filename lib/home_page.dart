import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:observatory/deals/ui/deals_filter.dart';
import 'package:observatory/search/search_provider.dart';
import 'package:observatory/settings/settings_provider.dart';
import 'package:observatory/settings/settings_state.dart';
import 'package:observatory/shared/ui/discounted_badge.dart';
import 'package:observatory/shared/widgets/error_message.dart';
import 'package:observatory/shared/widgets/progress_indicator.dart';
import 'package:observatory/waitlist/ui/waitlist_sorting_page.dart';

class HomePage extends ConsumerWidget {
  final StatefulNavigationShell child;

  const HomePage({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<SettingsState> settings = ref.watch(asyncSettingsProvider);

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) async {
          child.goBranch(index);

          if (index == 1 && index == child.currentIndex) {
            ref.watch(searchResultsProvider.notifier).setIsOpen(true);
            ref.watch(searchResultsProvider.notifier).setIsFocused(true);
          }

          if (index == 0 && index == child.currentIndex) {
            showDealsFilter(context);
          }

          if (index == 2 && index == child.currentIndex) {
            showWaitlistSorting(context);
          }
        },
        selectedIndex: child.currentIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.percent),
            icon: Icon(Icons.percent_rounded),
            label: 'Deals',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.search_rounded),
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.favorite_rounded),
            icon: DiscountedBadge(),
            label: 'Waitlist',
          ),
        ],
      ),
      body: settings.when(
        loading: () => const Center(
          child: ObservatoryProgressIndicator(),
        ),
        error: (error, stackTrace) {
          Logger().e(
            'Failed to load settings',
            error: error,
            stackTrace: stackTrace,
          );

          FirebaseCrashlytics.instance.recordError(
            error,
            stackTrace,
          );

          return ErrorMessage(
            message: 'Failed to load settings',
            helper: TextButton(
              child: const Text('Retry'),
              onPressed: () {
                ref.invalidate(asyncSettingsProvider);
              },
            ),
          );
        },
        data: (config) {
          return child;
        },
      ),
    );
  }
}
