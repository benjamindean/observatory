// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'igdb_game.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IGDBAccessTokenAdapter extends TypeAdapter<IGDBAccessToken> {
  @override
  final int typeId = 7;

  @override
  IGDBAccessToken read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IGDBAccessToken(
      token: fields[0] as String?,
      expires_at: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, IGDBAccessToken obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.token)
      ..writeByte(1)
      ..write(obj.expires_at);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IGDBAccessTokenAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameDetailsImpl _$$GameDetailsImplFromJson(Map<String, dynamic> json) =>
    _$GameDetailsImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      summary: json['summary'] as String?,
      storyline: json['storyline'] as String?,
      url: json['url'] as String?,
      first_release_date: (json['first_release_date'] as num?)?.toInt(),
      cover: json['cover'] == null
          ? null
          : IGDBCover.fromJson(json['cover'] as Map<String, dynamic>),
      screenshots: (json['screenshots'] as List<dynamic>?)
              ?.map((e) => IGDBScreenshot.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      videos: (json['videos'] as List<dynamic>?)
              ?.map((e) => IGDBVideo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      platforms: (json['platforms'] as List<dynamic>?)
              ?.map((e) => IGDBPlatform.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      themes: (json['themes'] as List<dynamic>?)
              ?.map((e) => IGDBTheme.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      websites: (json['websites'] as List<dynamic>?)
              ?.map((e) => IGDBWebsite.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$GameDetailsImplToJson(_$GameDetailsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'summary': instance.summary,
      'storyline': instance.storyline,
      'url': instance.url,
      'first_release_date': instance.first_release_date,
      'cover': instance.cover?.toJson(),
      'screenshots': instance.screenshots.map((e) => e.toJson()).toList(),
      'videos': instance.videos.map((e) => e.toJson()).toList(),
      'platforms': instance.platforms.map((e) => e.toJson()).toList(),
      'themes': instance.themes.map((e) => e.toJson()).toList(),
      'websites': instance.websites.map((e) => e.toJson()).toList(),
    };

_$IGDBScreenshotImpl _$$IGDBScreenshotImplFromJson(Map<String, dynamic> json) =>
    _$IGDBScreenshotImpl(
      id: (json['id'] as num?)?.toInt(),
      url: json['url'] as String?,
    );

Map<String, dynamic> _$$IGDBScreenshotImplToJson(
        _$IGDBScreenshotImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
    };

_$IGDBPlatformImpl _$$IGDBPlatformImplFromJson(Map<String, dynamic> json) =>
    _$IGDBPlatformImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      abbreviation: json['abbreviation'] as String?,
    );

Map<String, dynamic> _$$IGDBPlatformImplToJson(_$IGDBPlatformImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'abbreviation': instance.abbreviation,
    };

_$IGDBCoverImpl _$$IGDBCoverImplFromJson(Map<String, dynamic> json) =>
    _$IGDBCoverImpl(
      id: (json['id'] as num?)?.toInt(),
      url: json['url'] as String?,
    );

Map<String, dynamic> _$$IGDBCoverImplToJson(_$IGDBCoverImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
    };

_$IGDBThemeImpl _$$IGDBThemeImplFromJson(Map<String, dynamic> json) =>
    _$IGDBThemeImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$IGDBThemeImplToJson(_$IGDBThemeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

_$IGDBVideoImpl _$$IGDBVideoImplFromJson(Map<String, dynamic> json) =>
    _$IGDBVideoImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      video_id: json['video_id'] as String?,
    );

Map<String, dynamic> _$$IGDBVideoImplToJson(_$IGDBVideoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'video_id': instance.video_id,
    };

_$IGDBWebsiteImpl _$$IGDBWebsiteImplFromJson(Map<String, dynamic> json) =>
    _$IGDBWebsiteImpl(
      id: (json['id'] as num?)?.toInt(),
      url: json['url'] as String?,
    );

Map<String, dynamic> _$$IGDBWebsiteImplToJson(_$IGDBWebsiteImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
    };

_$IGDBAccessTokenImpl _$$IGDBAccessTokenImplFromJson(
        Map<String, dynamic> json) =>
    _$IGDBAccessTokenImpl(
      token: json['token'] as String?,
      expires_at: (json['expires_at'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$IGDBAccessTokenImplToJson(
        _$IGDBAccessTokenImpl instance) =>
    <String, dynamic>{
      'token': instance.token,
      'expires_at': instance.expires_at,
    };
