// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DRMImpl _$$DRMImplFromJson(Map<String, dynamic> json) => _$DRMImpl(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? 'Unknown',
    );

Map<String, dynamic> _$$DRMImplToJson(_$DRMImpl instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

_$PriceDetailsImpl _$$PriceDetailsImplFromJson(Map<String, dynamic> json) =>
    _$PriceDetailsImpl(
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
      amountInt: json['amountInt'] as int? ?? 0,
      currency: json['currency'] as String? ?? 'USD',
    );

Map<String, dynamic> _$$PriceDetailsImplToJson(_$PriceDetailsImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'amountInt': instance.amountInt,
      'currency': instance.currency,
    };

_$PriceImpl _$$PriceImplFromJson(Map<String, dynamic> json) => _$PriceImpl(
      price: PriceDetails.fromJson(json['price'] as Map<String, dynamic>),
      regular: PriceDetails.fromJson(json['regular'] as Map<String, dynamic>),
      cut: (json['cut'] as num?)?.toDouble() ?? 0,
      shop: Shop.fromJson(json['shop'] as Map<String, dynamic>),
      drm: (json['drm'] as List<dynamic>?)
              ?.map((e) => DRM.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      url: json['url'] as String? ?? '',
      voucher: json['voucher'] as String?,
      timestamp: json['timestamp'] as String? ?? '',
    );

Map<String, dynamic> _$$PriceImplToJson(_$PriceImpl instance) =>
    <String, dynamic>{
      'price': instance.price,
      'regular': instance.regular,
      'cut': instance.cut,
      'shop': instance.shop,
      'drm': instance.drm,
      'url': instance.url,
      'voucher': instance.voucher,
      'timestamp': instance.timestamp,
    };
