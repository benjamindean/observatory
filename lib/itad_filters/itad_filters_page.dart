import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:observatory/deals/providers/deals_provider.dart';
import 'package:observatory/itad_filters/providers/itad_filters_provider.dart';
import 'package:observatory/itad_filters/ui/bundled_only_tile.dart';
import 'package:observatory/itad_filters/ui/discount_slider.dart';
import 'package:observatory/itad_filters/ui/discounted_only_tile.dart';
import 'package:observatory/itad_filters/ui/nsfw_tile.dart';
import 'package:observatory/itad_filters/ui/platform_select_tile.dart';
import 'package:observatory/itad_filters/ui/price_slider.dart';
import 'package:observatory/itad_filters/ui/tags_filter_tile.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/models/itad_filters.dart';
import 'package:observatory/shared/ui/bottom_sheet_container.dart';
import 'package:observatory/shared/ui/bottom_sheet_heading.dart';
import 'package:observatory/shared/ui/close_bottom_sheet_button.dart';
import 'package:observatory/shared/ui/ory_small_button.dart';
import 'package:observatory/shared/ui/backdrop_container.dart';

void showITADFilters(BuildContext context) {
  showModalBottomSheet(
    useRootNavigator: true,
    useSafeArea: true,
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return const ITADFiltersPage();
    },
  );
}

class ITADFiltersPage extends ConsumerWidget {
  const ITADFiltersPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ITADFilters currentFilters = ref.read(
      itadFiltersProvider.select((value) => value.current),
    );
    final ITADFilters filters = ref.watch(
      itadFiltersProvider.select((value) => value.cached),
    );
    final bool isUpdated = filters != currentFilters;

    return BottomSheetContainer(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BottomSheetHeading(
              text: 'Filters',
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OrySmallButton(
                    onPressed: isUpdated
                        ? () {
                            ref.read(itadFiltersProvider.notifier).revert();
                          }
                        : null,
                    icon: Icons.restore_rounded,
                    label: 'Restore',
                    buttonColor: context.colors.scheme.tertiary,
                    textColor: context.colors.scheme.onTertiary,
                  ),
                  const SizedBox(
                    width: 6.0,
                  ),
                  OrySmallButton(
                    onPressed: isUpdated
                        ? () {
                            ref.read(itadFiltersProvider.notifier).save();
                            ref
                                .read(
                                  asyncDealsProvider(DealCategory.all).notifier,
                                )
                                .reset(withLoading: true);

                            context.pop();
                          }
                        : null,
                    icon: Icons.check,
                    label: 'Apply',
                  ),
                  const CloseBottomSheetButton(),
                ],
              ),
            ),
            const BackdropContainer(
              child: Column(
                children: [
                  TagsFilterTile(),
                  PriceSlider(),
                  DiscountSlider(),
                  PlatformSelectTile(),
                  SizedBox(height: 8.0),
                  BundledOnlyTile(),
                  DiscountedOnlyTile(),
                  NSFWTile(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
