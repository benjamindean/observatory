import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/deals/ui/deals_filter.dart';
import 'package:observatory/settings/settings_provider.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/widgets/settings_button.dart';

class DealsAppBar extends ConsumerWidget {
  const DealsAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DealCategory dealsTab = ref.watch(
      asyncSettingsProvider.select(
        (value) => value.value?.dealsTab ?? DealCategory.steam_top_sellers,
      ),
    );

    return SliverAppBar(
      floating: true,
      flexibleSpace: Stack(
        children: <Widget>[
          Positioned.fill(
            child: GestureDetector(
              child: Container(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                color: Colors.transparent,
                child: const Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(''),
                    ),
                  ],
                ),
              ),
              onTap: () {
                PrimaryScrollController.of(context).animateTo(
                  0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeIn,
                );
              },
            ),
          )
        ],
      ),
      actions: [
        FilledButton.icon(
          style: FilledButton.styleFrom(
            elevation: 1,
            side: BorderSide.none,
          ),
          onPressed: () => showDealsFilter(context),
          icon: const Icon(Icons.filter_list),
          label: Text(
            dealCategoryLabels[dealsTab]?['title'] ?? 'Unknown',
            style: context.textStyles.labelLarge.copyWith(
              color: context.colors.scheme.onPrimary,
            ),
          ),
        ),
        const SettingsButton(),
      ],
    );
  }
}
