import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:observatory/shared/models/deal.dart';

part 'deals_state.freezed.dart';

@freezed
class DealsState with _$DealsState {
  const factory DealsState({
    required List<Deal> deals,
    required bool hasReachedMax,
    required int pageNumber,
  }) = _DealsState;
}
