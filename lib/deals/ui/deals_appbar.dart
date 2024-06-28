import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/deals/providers/deals_provider.dart';
import 'package:observatory/deals/ui/deals_filter.dart';
import 'package:observatory/deals/ui/deals_info_app_bar.dart';
import 'package:observatory/itad_filters/itad_filters_page.dart';
import 'package:observatory/settings/providers/settings_provider.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/ui/ory_small_button.dart';
import 'package:observatory/shared/widgets/settings_button.dart';

class DealsAppBar extends ConsumerWidget {
  const DealsAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DealCategory dealsTab = ref.watch(
      asyncSettingsProvider.select(
        (value) => value.valueOrNull?.dealsTab ?? DealCategory.all,
      ),
    );

    return SliverAppBar(
      surfaceTintColor: context.colors.scheme.surfaceTint,
      floating: true,
      flexibleSpace: AppBar(
        title: GestureDetector(
          onTap: () {
            PrimaryScrollController.of(context).animateTo(
              0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeIn,
            );
          },
          child: DealsInfoAppBar(
            provider: asyncDealsProvider(dealsTab),
            dealsTab: dealsTab,
          ),
        ),
        actions: [
          OrySmallButton(
            onPressed: () => showDealsFilter(context),
            icon: Icons.type_specimen_rounded,
            label: 'Type',
          ),
          if (dealsTab == DealCategory.all)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: OrySmallButton(
                key: const Key('deals-filter-button'),
                onPressed: () => showITADFilters(context),
                icon: Icons.filter_list,
                textColor: context.colors.scheme.onSecondary,
                buttonColor: context.colors.scheme.secondary,
                label: 'Filter',
              ),
            ),
          const SettingsButton(),
        ],
      ),
    );
  }
}
