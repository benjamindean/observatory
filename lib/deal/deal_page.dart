import 'package:easy_refresh/easy_refresh.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/deal/ui/page_sections/bundles_tile.dart';
import 'package:observatory/deal/ui/deal_app_bar.dart';
import 'package:observatory/deal/ui/deal_page_bottom_appbar.dart';
import 'package:observatory/deal/ui/page_sections/links_tile.dart';
import 'package:observatory/deal/ui/page_sections/lowest_price_tile.dart';
import 'package:observatory/deal/ui/price_listview.dart';
import 'package:observatory/deal/ui/page_sections/reviews_tile.dart';
import 'package:observatory/deal/deal_provider.dart';
import 'package:observatory/deal/ui/page_sections/screenshots_tile.dart';
import 'package:observatory/deal/ui/page_sections/summary_tile.dart';
import 'package:observatory/deal/ui/page_sections/tags_tile.dart';
import 'package:observatory/shared/context_extension.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/ui/is_there_any_deal_info.dart';
import 'package:observatory/shared/ui/pull_to_refresh.dart';
import 'package:observatory/shared/widgets/list_heading.dart';

class DealPage extends ConsumerWidget {
  final Deal deal;

  const DealPage({
    super.key,
    required this.deal,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FirebaseAnalytics.instance.logScreenView(
      screenName: 'deal_page',
      parameters: {
        'id': deal.id,
        'title': deal.titleParsed,
      },
    );

    final Deal dealState = ref.watch(dealProvider(deal));

    return Container(
      color: context.elevatedBottomAppBarColor,
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: DealPageBottomAppBar(deal: dealState),
          body: PullToRefresh(
            onRefresh: () async {
              return ref.watch(dealProvider(deal).notifier).refresh();
            },
            child: CustomScrollView(
              key: const Key('deal_scroll_view'),
              slivers: [
                DealAppBar(deal: deal),
                const HeaderLocator.sliver(),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SummaryTile(deal: deal),
                      ReviewsTile(deal: deal),
                      TagsTile(deal: deal),
                      LowestPriceTile(deal: deal),
                      BundlesTile(deal: deal),
                      LinksTile(deal: deal),
                      SscreenshotsTile(deal: deal),
                    ],
                  ),
                ),
                const SliverToBoxAdapter(
                  child: ListHeading(title: 'Prices'),
                ),
                PriceListView(
                  prices: dealState.prices,
                ),
                const SliverToBoxAdapter(
                  child: IsThereAnyDealInfo(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
