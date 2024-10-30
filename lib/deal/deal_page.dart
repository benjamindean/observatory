import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/deal/ui/game_user_info_row.dart';
import 'package:observatory/deal/ui/history_chart.dart';
import 'package:observatory/deal/ui/page_sections/bundles_tile.dart';
import 'package:observatory/deal/ui/deal_app_bar.dart';
import 'package:observatory/deal/ui/deal_page_bottom_appbar.dart';
import 'package:observatory/deal/ui/page_sections/links_tile.dart';
import 'package:observatory/deal/ui/page_sections/lowest_price_tile.dart';
import 'package:observatory/deal/ui/page_sections/release_date_tile.dart';
import 'package:observatory/deal/ui/page_sections/supported_platforms_tile.dart';
import 'package:observatory/deal/ui/price_listview.dart';
import 'package:observatory/deal/ui/page_sections/reviews_tile.dart';
import 'package:observatory/deal/providers/deal_provider.dart';
import 'package:observatory/deal/ui/page_sections/screenshots/screenshots_tile.dart';
import 'package:observatory/deal/ui/page_sections/summary_tile.dart';
import 'package:observatory/deal/ui/page_sections/tags_tile.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/ui/is_there_any_deal_info.dart';
import 'package:observatory/shared/widgets/list_heading.dart';
import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';

class DealPage extends ConsumerWidget {
  const DealPage({
    super.key,
    required this.deal,
  });

  final Deal deal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Deal dealState = ref.watch(dealProvider(deal));

    return ColoredBox(
      color: context.colors.scheme.surfaceContainer,
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: DealPageBottomAppBar(
            deal: dealState,
          ),
          body: CustomScrollView(
            key: const Key('deal-scroll-view'),
            slivers: [
              DealAppBar(deal: deal),
              PinnedHeaderSliver(
                child: ColoredBox(
                  color: context.colors.scheme.surfaceContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          deal.titleParsed,
                          style: context.textStyles.titleMedium.copyWith(
                            color: context.colors.scheme.onSurface,
                          ),
                        ),
                        GameUserInfoRow(deal: deal),
                      ],
                    ),
                  ),
                ),
              ),
              SliverList.list(
                key: Key('deal-${deal.id}-sliver-list'),
                children: [
                  const SizedBox(height: 8.0),
                  SummaryTile(deal: deal),
                  ReleaseDateTile(deal: deal),
                  TagsTile(deal: deal),
                  SupportedPlatformsTile(deal: deal),
                  ScreenshotsTile(deal: deal),
                  ReviewsTile(deal: deal),
                  LowestPriceTile(deal: deal),
                  BundlesTile(deal: deal),
                  LinksTile(deal: deal),
                ],
              ),
              const SliverToBoxAdapter(
                child: ListHeading(title: 'Prices'),
              ),
              PriceListView(
                prices: dealState.prices,
              ),
              const SliverToBoxAdapter(
                child: ListHeading(
                  title: 'Price History',
                  subtitle: Text('Past 6 months'),
                ),
              ),
              SliverToBoxAdapter(
                child: HistoryChart(
                  id: deal.id,
                ),
              ),
              const SliverToBoxAdapter(
                child: IsThereAnyDealInfo(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
