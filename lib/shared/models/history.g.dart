// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HistoryPriceImpl _$$HistoryPriceImplFromJson(Map<String, dynamic> json) =>
    _$HistoryPriceImpl(
      price: PriceDetails.fromJson(json['price'] as Map<String, dynamic>),
      regular: PriceDetails.fromJson(json['regular'] as Map<String, dynamic>),
      cut: (json['cut'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$HistoryPriceImplToJson(_$HistoryPriceImpl instance) =>
    <String, dynamic>{
      'price': instance.price,
      'regular': instance.regular,
      'cut': instance.cut,
    };

_$HistoryImpl _$$HistoryImplFromJson(Map<String, dynamic> json) =>
    _$HistoryImpl(
      timestamp: (json['timestamp'] as num).toInt(),
      shop: json['shop'] == null
          ? null
          : Shop.fromJson(json['shop'] as Map<String, dynamic>),
      deal: json['deal'] == null
          ? null
          : HistoryPrice.fromJson(json['deal'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$HistoryImplToJson(_$HistoryImpl instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'shop': instance.shop,
      'deal': instance.deal,
    };
