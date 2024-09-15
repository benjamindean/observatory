// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'steam_import_state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SteamUserAdapter extends TypeAdapter<SteamUser> {
  @override
  final int typeId = 10;

  @override
  SteamUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SteamUser(
      steamid: fields[0] as String?,
      personaname: fields[1] as String?,
      profileurl: fields[2] as String?,
      avatarfull: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SteamUser obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.steamid)
      ..writeByte(1)
      ..write(obj.personaname)
      ..writeByte(2)
      ..write(obj.profileurl)
      ..writeByte(3)
      ..write(obj.avatarfull);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SteamUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SteamUserImpl _$$SteamUserImplFromJson(Map<String, dynamic> json) =>
    _$SteamUserImpl(
      steamid: json['steamid'] as String?,
      personaname: json['personaname'] as String?,
      profileurl: json['profileurl'] as String?,
      avatarfull: json['avatarfull'] as String?,
    );

Map<String, dynamic> _$$SteamUserImplToJson(_$SteamUserImpl instance) =>
    <String, dynamic>{
      'steamid': instance.steamid,
      'personaname': instance.personaname,
      'profileurl': instance.profileurl,
      'avatarfull': instance.avatarfull,
    };
