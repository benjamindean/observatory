// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DealAdapter extends TypeAdapter<Deal> {
  @override
  final int typeId = 1;

  @override
  Deal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Deal(
      id: fields[0] as String,
      slug: fields[1] as String,
      title: fields[2] as String,
      added: fields[3] as int,
      source: fields[4] as DealSource,
      prices: (fields[5] as List?)?.cast<Price>(),
      priceCutUpdatedAt: fields[6] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Deal obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.slug)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.added)
      ..writeByte(4)
      ..write(obj.source)
      ..writeByte(5)
      ..write(obj.prices)
      ..writeByte(6)
      ..write(obj.priceCutUpdatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DealAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DealSourceAdapter extends TypeAdapter<DealSource> {
  @override
  final int typeId = 3;

  @override
  DealSource read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DealSource.itad;
      case 1:
        return DealSource.steam;
      default:
        return DealSource.itad;
    }
  }

  @override
  void write(BinaryWriter writer, DealSource obj) {
    switch (obj) {
      case DealSource.itad:
        writer.writeByte(0);
        break;
      case DealSource.steam:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DealSourceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DealImpl _$$DealImplFromJson(Map<String, dynamic> json) => _$DealImpl(
      id: json['id'] as String,
      slug: json['slug'] as String? ?? '',
      type: json['type'] as String? ?? 'game',
      title: json['title'] as String? ?? '',
      steamId: json['steamId'] as String?,
      info: json['info'] == null
          ? null
          : Info.fromJson(json['info'] as Map<String, dynamic>),
      overview: json['overview'] == null
          ? null
          : Overview.fromJson(json['overview'] as Map<String, dynamic>),
      isLoading: json['isLoading'] as bool? ?? false,
      added: (json['added'] as num?)?.toInt() ?? 0,
      source: $enumDecodeNullable(_$DealSourceEnumMap, json['source']) ??
          DealSource.itad,
      prices: (json['prices'] as List<dynamic>?)
          ?.map((e) => Price.fromJson(e as Map<String, dynamic>))
          .toList(),
      priceCutUpdatedAt: (json['priceCutUpdatedAt'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$DealImplToJson(_$DealImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'type': instance.type,
      'title': instance.title,
      'steamId': instance.steamId,
      'info': instance.info,
      'overview': instance.overview,
      'isLoading': instance.isLoading,
      'added': instance.added,
      'source': _$DealSourceEnumMap[instance.source]!,
      'prices': instance.prices,
      'priceCutUpdatedAt': instance.priceCutUpdatedAt,
    };

const _$DealSourceEnumMap = {
  DealSource.itad: 'itad',
  DealSource.steam: 'steam',
};
