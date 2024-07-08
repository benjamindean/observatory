import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:observatory/deals/ui/deals_filter.dart';
import 'package:observatory/itad_filters/itad_filters_page.dart';
import 'package:observatory/search/providers/search_provider.dart';
import 'package:observatory/settings/providers/settings_provider.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/settings/state/settings_state.dart';
import 'package:observatory/shared/ui/constants.dart';
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
    final DealCategory dealsTab = ref.watch(
      asyncSettingsProvider.select(
        (value) => value.valueOrNull?.dealsTab ?? DealCategory.all,
      ),
    );

    return Scaffold(
      key: const Key('home-page'),
      bottomNavigationBar: NavigationBar(
        elevation: APPBAR_ELEVATION,
        backgroundColor: context.colors.scheme.surfaceContainer,
        surfaceTintColor: context.colors.scheme.surfaceTint,
        onDestinationSelected: (int index) async {
          child.goBranch(index);

          if (index == 1 && index == child.currentIndex) {
            return ref.read(searchResultsProvider.notifier).setIsOpen();
          }

          if (index == 0 && index == child.currentIndex) {
            if (dealsTab == DealCategory.all) {
              return showITADFilters(context);
            }

            return showDealsFilter(context);
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

          FirebaseCrashlytics.instance.recordError(
            error,
            stackTrace,
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
