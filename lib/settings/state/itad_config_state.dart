import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:observatory/shared/models/store.dart';

part 'itad_config_state.freezed.dart';
part 'itad_config_state.g.dart';

@freezed
class ITADConfigState with _$ITADConfigState {
  factory ITADConfigState({
    @Default('US') String selectedCountry,
    @Default('USD') String currency,
    required List<int> selectedStores,
    required List<Store> stores,
  }) = _ITADConfigState;

  factory ITADConfigState.fromJson(Map<String, Object?> json) =>
      _$ITADConfigStateFromJson(json);
}
