import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:observatory/itad_filters/itad_filters_page.dart';
import 'package:observatory/search/providers/search_provider.dart';
import 'package:observatory/settings/providers/settings_provider.dart';
import 'package:observatory/settings/state/settings_state.dart';
import 'package:observatory/shared/ui/discounted_badge.dart';
import 'package:observatory/shared/widgets/error_message.dart';
import 'package:observatory/shared/widgets/progress_indicator.dart';
import 'package:observatory/waitlist/ui/waitlist_sorting_page.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

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
      key: const Key('home-page'),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) async {
          child.goBranch(index);

          if (index == 1 && index == child.currentIndex) {
            return ref.read(dealSearchProvider.notifier).setIsOpen();
          }

          if (index == 0 && index == child.currentIndex) {
            return showITADFilters(context);
          }

          if (index == 2 && index == child.currentIndex) {
            return showWaitlistSorting(context);
          }
        },
        selectedIndex: child.currentIndex,
        destinations: const <Widget>[
          NavigationDestination(
            key: Key('navigation-deals'),
            selectedIcon: Icon(Icons.percent),
            icon: Icon(Icons.percent_rounded),
            label: 'Deals',
          ),
          NavigationDestination(
            key: Key('navigation-search'),
            selectedIcon: Icon(Icons.search_rounded),
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            key: Key('navigation-waitlist'),
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

          Sentry.captureException(
            error,
            stackTrace: stackTrace,
          );

          return ErrorMessage(
            message: 'Failed to load settings. Please try again later.',
            icon: FontAwesomeIcons.solidFaceDizzy,
            helper: TextButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
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
