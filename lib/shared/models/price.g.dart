// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PriceDetailsAdapter extends TypeAdapter<PriceDetails> {
  @override
  final int typeId = 6;

  @override
  PriceDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PriceDetails(
      amount: fields[0] as double,
      amountInt: fields[1] as int,
      currency: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PriceDetails obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.amount)
      ..writeByte(1)
      ..write(obj.amountInt)
      ..writeByte(2)
      ..write(obj.currency);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PriceDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PriceAdapter extends TypeAdapter<Price> {
  @override
  final int typeId = 4;

  @override
  Price read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Price(
      price: fields[0] as PriceDetails,
      regular: fields[1] as PriceDetails,
      cut: fields[2] as double,
      shop: fields[3] as Shop,
      voucher: fields[4] as String?,
      timestamp: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Price obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.price)
      ..writeByte(1)
      ..write(obj.regular)
      ..writeByte(2)
      ..write(obj.cut)
      ..writeByte(3)
      ..write(obj.shop)
      ..writeByte(4)
      ..write(obj.voucher)
      ..writeByte(5)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PriceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DRMImpl _$$DRMImplFromJson(Map<String, dynamic> json) => _$DRMImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? 'Unknown',
    );

Map<String, dynamic> _$$DRMImplToJson(_$DRMImpl instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

_$PriceDetailsImpl _$$PriceDetailsImplFromJson(Map<String, dynamic> json) =>
    _$PriceDetailsImpl(
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
      amountInt: (json['amountInt'] as num?)?.toInt() ?? 0,
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
