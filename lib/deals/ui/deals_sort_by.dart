import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/itad_filters/providers/itad_filters_provider.dart';
import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:observatory/shared/api/constans.dart';
import 'package:observatory/shared/ui/bottom_sheet_heading.dart';
import 'package:observatory/shared/ui/close_bottom_sheet_button.dart';

void showDealsSortBy(BuildContext context) {
  showModalBottomSheet(
    useRootNavigator: true,
    useSafeArea: true,
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return const DealsSortBy();
    },
  );
}

class DealsSortBy extends ConsumerWidget {
  const DealsSortBy({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String sortBy = ref.watch(
      itadFiltersProvider.select(
        (value) => value.current.sortBy ?? SortBy.trending.name,
      ),
    );

    return SafeArea(
      child: CustomScrollView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: BottomSheetHeading(
              text: 'Sort By',
              trailing: CloseBottomSheetButton(),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final SortBy value = SortBy.values[index];

                return ListTile(
                  key: Key('deal-category-${value.name.toString()}'),
                  selectedTileColor: context.colors.scheme.secondary,
                  selectedColor: context.colors.scheme.onSecondary,
                  selected: value.name == sortBy,
                  onTap: () {
                    ref.read(itadFiltersProvider.notifier).setSortBy(value);
                    ref.read(itadFiltersProvider.notifier).save();
                  },
                  title: Text(
                    SORT_BY_VALUES[value] ?? SortBy.trending.name,
                    style: context.textStyles.titleMedium.copyWith(
                      color: value.name == sortBy
                          ? context.colors.scheme.onSecondary
                          : context.colors.scheme.onSurface,
                    ),
                  ),
                );
              },
              childCount: SortBy.values.length,
            ),
          ),
        ],
      ),
    );
  }
}
