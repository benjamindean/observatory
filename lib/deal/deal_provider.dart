import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:observatory/deal/info_provider.dart';
import 'package:observatory/deal/overview_provider.dart';
import 'package:observatory/shared/api/api.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/models/price.dart';

class DealNotifier extends AutoDisposeFamilyNotifier<Deal, Deal> {
  @override
  Deal build(Deal arg) => arg;

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true);

    ref.invalidate(infoProvider(state.id));
    ref.invalidate(overviewProvider(state.id));

    final Map<String, List<Price>?> response = await GetIt.I<API>().prices(
      ids: [state.id],
    );

    state = state.copyWith(
      isLoading: false,
      prices: response[state.id] ?? state.prices,
    );
  }
}

final dealProvider = NotifierProvider.family
    .autoDispose<DealNotifier, Deal, Deal>(DealNotifier.new);
