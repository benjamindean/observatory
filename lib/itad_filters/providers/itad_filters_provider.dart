import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/models/itad_filters.dart';

class ITADFiltersNotifier extends AutoDisposeNotifier<ITADFilters> {
  @override
  ITADFilters build() {
    return GetIt.I<SettingsRepository>().getITADFilters();
  }

  void setMaxPrice(double maxPrice) {
    if (maxPrice == state.priceBounds.max) {
      state = state.copyWith(price: null);

      return;
    }

    state = state.copyWith(
      price: MinMax(
        min: state.priceBounds.min,
        max: maxPrice.toInt(),
      ),
    );
  }

  void setMinDiscount(double minDiscount) {
    if (minDiscount == state.cutBounds.min) {
      state = state.copyWith(cut: null);

      return;
    }

    state = state.copyWith(
      cut: MinMax(
        min: minDiscount.toInt(),
        max: state.cutBounds.max,
      ),
    );
  }

  void setBundled(bool isBundled) {
    if (isBundled == false) {
      state = state.copyWith(bundled: null);

      return;
    }

    state = state.copyWith(
      bundled: isBundled,
    );
  }

  Future<void> save() {
    return GetIt.I<SettingsRepository>().setITADFilters(state);
  }

  Future<void> reset() {
    state = const ITADFilters();

    return GetIt.I<SettingsRepository>().setITADFilters(state);
  }

  void addTags(List<String> tags) {
    state = state.copyWith(
      tags:
          Set<String>.from(List.from(state.tags ?? [])..addAll(tags)).toList(),
    );
  }

  void removeTag(String tag) {
    state = state.copyWith(
      tags: List.from(state.tags ?? [])..remove(tag),
    );
  }
}

final itadFiltersProvider =
    NotifierProvider.autoDispose<ITADFiltersNotifier, ITADFilters>(
  ITADFiltersNotifier.new,
);
