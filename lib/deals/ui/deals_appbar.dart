import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:observatory/deals/ui/deals_sort_by.dart';
import 'package:observatory/deals/ui/deals_info_app_bar.dart';
import 'package:observatory/itad_filters/itad_filters_page.dart';
import 'package:observatory/shared/ui/ory_small_button.dart';
import 'package:observatory/shared/widgets/settings_button.dart';

class DealsAppBar extends StatelessWidget {
  const DealsAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
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
          child: DealsInfoAppBar(),
        ),
        actions: [
          OrySmallButton(
            onPressed: () => showDealsSortBy(context),
            icon: Icons.sort,
            label: 'Sort',
          ),
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
