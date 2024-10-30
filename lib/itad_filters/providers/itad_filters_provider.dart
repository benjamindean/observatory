import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:observatory/deals/providers/deals_provider.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/constans.dart';
import 'package:observatory/shared/models/itad_filters.dart';

class ITADFiltersNotifier extends AutoDisposeNotifier<ITADFiltersConfig> {
  @override
  ITADFiltersConfig build() {
    final ITADFilters filters = GetIt.I<SettingsRepository>().getITADFilters();

    return ITADFiltersConfig(
      cached: filters,
      current: filters,
    );
  }

  void setMaxPrice(double maxPrice) {
    if (maxPrice == FilterBounds.price.max) {
      state = state.copyWith(
        cached: state.cached.copyWith(price: null),
      );

      return;
    }

    state = state.copyWith(
      cached: state.cached.copyWith(
        price: MinMax(
          min: FilterBounds.price.min,
          max: maxPrice.toInt(),
        ),
      ),
    );
  }

  void setMinDiscount(double minDiscount) {
    if (minDiscount == FilterBounds.cut.min) {
      state = state.copyWith(
        cached: state.cached.copyWith(cut: null),
      );

      return;
    }

    state = state.copyWith(
      cached: state.cached.copyWith(
        cut: MinMax(
          min: minDiscount.toInt(),
          max: FilterBounds.cut.max,
        ),
      ),
    );
  }

  void setBundled(bool isBundled) {
    if (!isBundled) {
      state = state.copyWith(
        cached: state.cached.copyWith(bundled: null),
      );

      return;
    }

    state = state.copyWith(
      cached: state.cached.copyWith(bundled: isBundled),
    );
  }

  void setNSFW(bool isMature) {
    state = state.copyWith(
      cached: state.cached.copyWith(mature: isMature),
    );
  }

  void setNonDeals(bool isNonDeals) {
    state = state.copyWith(
      cached: state.cached.copyWith(nondeals: isNonDeals),
    );
  }

  void setPlatforms(List<int> platforms) {
    state = state.copyWith(
      cached: state.cached.copyWith(
        platform: platforms.length == 3 ? null : platforms,
      ),
    );
  }

  Future<void> setSortBy(SortDealsBy sortBy) async {
    state = state.copyWith(
      current: state.current.copyWith(
        sortBy: sortBy.name,
      ),
      cached: state.cached.copyWith(
        sortBy: sortBy.name,
      ),
    );

    await GetIt.I<SettingsRepository>().setITADFilters(state.current);

    return ref.read(asyncDealsProvider.notifier).reset(withLoading: true);
  }

  Future<void> save() async {
    await GetIt.I<SettingsRepository>().setITADFilters(state.cached);

    state = ITADFiltersConfig(
      cached: state.cached,
      current: state.cached,
    );
  }

  Future<void> reset() async {
    final ITADFilters filters = ITADFilters(
      sortBy: GetIt.I<SettingsRepository>().getITADFilters().sortBy,
    );

    await GetIt.I<SettingsRepository>().setITADFilters(filters);

    state = ITADFiltersConfig(
      cached: filters,
      current: filters,
    );
  }

  void revert() {
    state = ITADFiltersConfig(
      cached: state.current,
      current: state.current,
    );
  }

  void addTags(List<String> tags) {
    state = state.copyWith(
      cached: state.cached.copyWith(
        tags: Set<String>.of(List.of(state.cached.tags ?? [])..addAll(tags))
            .toList(),
      ),
    );
  }

  void removeTag(String tag) {
    state = state.copyWith(
      cached: state.cached.copyWith(
        tags: List.of(state.cached.tags ?? [])..remove(tag),
      ),
    );
  }
}

final itadFiltersProvider =
    NotifierProvider.autoDispose<ITADFiltersNotifier, ITADFiltersConfig>(
  ITADFiltersNotifier.new,
);
