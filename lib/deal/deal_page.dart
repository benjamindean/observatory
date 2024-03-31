import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/deal/ui/bundles_tile.dart';
import 'package:observatory/deal/ui/deal_app_bar.dart';
import 'package:observatory/deal/ui/deal_page_bottom_appbar.dart';
import 'package:observatory/deal/ui/links_tile.dart';
import 'package:observatory/deal/ui/lowest_price_tile.dart';
import 'package:observatory/deal/ui/price_listview.dart';
import 'package:observatory/deal/ui/reviews_tile.dart';
import 'package:observatory/deal/deal_provider.dart';
import 'package:observatory/deal/ui/tags_tile.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/ui/is_there_any_deal_info.dart';
import 'package:observatory/shared/widgets/list_heading.dart';
import 'package:observatory/shared/widgets/progress_indicator.dart';

class DealPage extends ConsumerWidget {
  final Deal deal;

  const DealPage({
    super.key,
    required this.deal,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Deal dealState = ref.watch(dealProvider(deal));

    return Container(
      color: ElevationOverlay.applySurfaceTint(
        context.colors.canvas,
        context.colors.scheme.surfaceTint,
        3,
      ),
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: DealPageBottomAppBar(deal: dealState),
          body: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: dealState.isLoading
                ? [
                    DealAppBar(deal: deal),
                    const SliverFillRemaining(
                      child: ITADProgressIndicator(),
                    )
                  ]
                : [
                    DealAppBar(deal: deal),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          ReviewsTile(deal: deal),
                          TagsTile(deal: deal),
                          LowestPriceTile(deal: deal),
                          BundlesTile(deal: deal),
                          LinksTile(deal: deal),
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
    );
  }
}
