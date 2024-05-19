// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'observatory_theme.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ObservatoryThemeAdapter extends TypeAdapter<ObservatoryTheme> {
  @override
  final int typeId = 2;

  @override
  ObservatoryTheme read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ObservatoryTheme(
      mode: fields[0] as String,
      isTrueBlack: fields[1] as bool,
      scheme: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ObservatoryTheme obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.mode)
      ..writeByte(1)
      ..write(obj.isTrueBlack)
      ..writeByte(2)
      ..write(obj.scheme);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ObservatoryThemeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ObservatoryThemeImpl _$$ObservatoryThemeImplFromJson(
        Map<String, dynamic> json) =>
    _$ObservatoryThemeImpl(
      mode: json['mode'] as String,
      isTrueBlack: json['isTrueBlack'] as bool,
      scheme: json['scheme'] as String? ?? 'mandyRed',
    );

Map<String, dynamic> _$$ObservatoryThemeImplToJson(
        _$ObservatoryThemeImpl instance) =>
    <String, dynamic>{
      'mode': instance.mode,
      'isTrueBlack': instance.isTrueBlack,
      'scheme': instance.scheme,
    };
