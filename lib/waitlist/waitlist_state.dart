import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:observatory/shared/models/deal.dart';

part 'waitlist_state.freezed.dart';

@freezed
class WaitListState with _$WaitListState {
  const factory WaitListState({
    required List<String> ids,
    required List<Deal> deals,
  }) = _WaitListState;
}
