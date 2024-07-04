// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itad_config_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ITADConfigStateImpl _$$ITADConfigStateImplFromJson(
        Map<String, dynamic> json) =>
    _$ITADConfigStateImpl(
      selectedCountry: json['selectedCountry'] as String,
      currency: json['currency'] as String? ?? 'USD',
      selectedStores: (json['selectedStores'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      stores: (json['stores'] as List<dynamic>)
          .map((e) => Store.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ITADConfigStateImplToJson(
        _$ITADConfigStateImpl instance) =>
    <String, dynamic>{
      'selectedCountry': instance.selectedCountry,
      'currency': instance.currency,
      'selectedStores': instance.selectedStores,
      'stores': instance.stores,
    };
