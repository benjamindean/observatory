import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:observatory/bookmarks/ui/bookmarks_page.dart';
import 'package:observatory/deal/deal_page.dart';
import 'package:observatory/deals/deals_page.dart';
import 'package:observatory/home_page.dart';
import 'package:observatory/itad_filters/tags_list_page.dart';
import 'package:observatory/search/search_page.dart';
import 'package:observatory/settings/purchase/purchase_page.dart';
import 'package:observatory/settings/settings_page.dart';
import 'package:observatory/settings/stores_select/stores_select_page.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/waitlist/waitlist_page.dart';
// import 'package:sentry_flutter/sentry_flutter.dart';

enum NavigationBranch {
  deals,
  search,
  waitlist,
}

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKeyDeals = GlobalKey<NavigatorState>();
final shellNavigatorKeySearch = GlobalKey<NavigatorState>();
final shellNavigatorKeyWaitlist = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  // observers: [
  //   SentryNavigatorObserver(),
  // ],
  initialLocation: '/deals',
  navigatorKey: rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return HomePage(
          child: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: shellNavigatorKeyDeals,
          routes: [
            GoRoute(
              name: 'deals',
              path: '/deals',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: DealsPage(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: shellNavigatorKeySearch,
          routes: [
            GoRoute(
              name: 'search',
              path: '/search',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: SearchPage(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: shellNavigatorKeyWaitlist,
          routes: [
            GoRoute(
              name: 'waitlist',
              path: '/waitlist',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: WaitListPage(),
              ),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      name: 'settings',
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      name: 'bookmarks',
      path: '/bookmarks',
      builder: (context, state) => const BookmarksPage(),
    ),
    GoRoute(
      name: 'store-select',
      path: '/store-select',
      builder: (context, state) => const StoreSelectPage(),
    ),
    GoRoute(
      name: 'deal',
      path: '/deal',
      builder: (context, state) => DealPage(deal: state.extra as Deal),
    ),
    GoRoute(
      name: 'tags-select',
      path: '/tags-select',
      builder: (context, state) => const TagsListPage(),
    ),
    GoRoute(
      name: 'observatory-plus',
      path: '/observatory-plus',
      builder: (context, state) => const PurchasePage(),
    ),
  ],
);
