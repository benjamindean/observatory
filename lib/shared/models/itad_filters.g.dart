// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itad_filters.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MinMaxAdapter extends TypeAdapter<MinMax> {
  @override
  final int typeId = 9;

  @override
  MinMax read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MinMax(
      min: fields[0] as int,
      max: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MinMax obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.min)
      ..writeByte(1)
      ..write(obj.max);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MinMaxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ITADFiltersAdapter extends TypeAdapter<ITADFilters> {
  @override
  final int typeId = 8;

  @override
  ITADFilters read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ITADFilters(
      price: fields[0] as MinMax?,
      cut: fields[1] as MinMax?,
      bundled: fields[2] as bool?,
      tags: (fields[3] as List?)?.cast<String>(),
      mature: fields[4] as bool,
      nondeals: fields[5] as bool,
      platform: (fields[6] as List?)?.cast<int>(),
      sortBy: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ITADFilters obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.price)
      ..writeByte(1)
      ..write(obj.cut)
      ..writeByte(2)
      ..write(obj.bundled)
      ..writeByte(3)
      ..write(obj.tags)
      ..writeByte(4)
      ..write(obj.mature)
      ..writeByte(5)
      ..write(obj.nondeals)
      ..writeByte(6)
      ..write(obj.platform)
      ..writeByte(7)
      ..write(obj.sortBy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ITADFiltersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MinMaxImpl _$$MinMaxImplFromJson(Map<String, dynamic> json) => _$MinMaxImpl(
      min: (json['min'] as num?)?.toInt() ?? 0,
      max: (json['max'] as num?)?.toInt() ?? 100,
    );

Map<String, dynamic> _$$MinMaxImplToJson(_$MinMaxImpl instance) =>
    <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
    };

_$ITADFiltersImpl _$$ITADFiltersImplFromJson(Map<String, dynamic> json) =>
    _$ITADFiltersImpl(
      price: json['price'] == null
          ? null
          : MinMax.fromJson(json['price'] as Map<String, dynamic>),
      cut: json['cut'] == null
          ? null
          : MinMax.fromJson(json['cut'] as Map<String, dynamic>),
      bundled: json['bundled'] as bool?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      mature: json['mature'] as bool? ?? false,
      nondeals: json['nondeals'] as bool? ?? true,
      platform: (json['platform'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      sortBy: json['sortBy'] as String? ?? 'trending',
    );

Map<String, dynamic> _$$ITADFiltersImplToJson(_$ITADFiltersImpl instance) =>
    <String, dynamic>{
      'price': instance.price?.toJson(),
      'cut': instance.cut?.toJson(),
      'bundled': instance.bundled,
      'tags': instance.tags,
      'mature': instance.mature,
      'nondeals': instance.nondeals,
      'platform': instance.platform,
      'sortBy': instance.sortBy,
    };

_$ITADFiltersConfigImpl _$$ITADFiltersConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$ITADFiltersConfigImpl(
      cached: ITADFilters.fromJson(json['cached'] as Map<String, dynamic>),
      current: ITADFilters.fromJson(json['current'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ITADFiltersConfigImplToJson(
        _$ITADFiltersConfigImpl instance) =>
    <String, dynamic>{
      'cached': instance.cached,
      'current': instance.current,
    };
