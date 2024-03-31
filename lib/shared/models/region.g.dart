// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'region.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RegionImpl _$$RegionImplFromJson(Map<String, dynamic> json) => _$RegionImpl(
      code: json['code'] as String? ?? 'none',
      countries:
          (json['countries'] as List<dynamic>).map((e) => e as String).toList(),
      currency: Currency.fromJson(json['currency'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$RegionImplToJson(_$RegionImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'countries': instance.countries,
      'currency': instance.currency,
    };
