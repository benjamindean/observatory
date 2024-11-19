// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itad_state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ITADUserAdapter extends TypeAdapter<ITADUser> {
  @override
  final int typeId = 11;

  @override
  ITADUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ITADUser(
      username: fields[0] as String?,
      credentials: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ITADUser obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.credentials);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ITADUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ITADUserImpl _$$ITADUserImplFromJson(Map<String, dynamic> json) =>
    _$ITADUserImpl(
      username: json['username'] as String?,
      credentials: json['credentials'] as String?,
    );

Map<String, dynamic> _$$ITADUserImplToJson(_$ITADUserImpl instance) =>
    <String, dynamic>{
      'username': instance.username,
      'credentials': instance.credentials,
    };
