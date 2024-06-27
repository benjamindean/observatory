// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

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
              ?.map((e) => GameScreenshot.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      videos: (json['videos'] as List<dynamic>?)
              ?.map((e) => GameVideo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      platforms: (json['platforms'] as List<dynamic>?)
              ?.map((e) => GamePlatform.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      themes: (json['themes'] as List<dynamic>?)
              ?.map((e) => GameTheme.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      websites: (json['websites'] as List<dynamic>?)
              ?.map((e) => GameWebsite.fromJson(e as Map<String, dynamic>))
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

_$GameScreenshotImpl _$$GameScreenshotImplFromJson(Map<String, dynamic> json) =>
    _$GameScreenshotImpl(
      id: (json['id'] as num?)?.toInt(),
      url: json['url'] as String?,
    );

Map<String, dynamic> _$$GameScreenshotImplToJson(
        _$GameScreenshotImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
    };

_$GamePlatformImpl _$$GamePlatformImplFromJson(Map<String, dynamic> json) =>
    _$GamePlatformImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      abbreviation: json['abbreviation'] as String?,
    );

Map<String, dynamic> _$$GamePlatformImplToJson(_$GamePlatformImpl instance) =>
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

_$GameThemeImpl _$$GameThemeImplFromJson(Map<String, dynamic> json) =>
    _$GameThemeImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$GameThemeImplToJson(_$GameThemeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

_$GameVideoImpl _$$GameVideoImplFromJson(Map<String, dynamic> json) =>
    _$GameVideoImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      video_id: json['video_id'] as String?,
    );

Map<String, dynamic> _$$GameVideoImplToJson(_$GameVideoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'video_id': instance.video_id,
    };

_$GameWebsiteImpl _$$GameWebsiteImplFromJson(Map<String, dynamic> json) =>
    _$GameWebsiteImpl(
      id: (json['id'] as num?)?.toInt(),
      url: json['url'] as String?,
    );

Map<String, dynamic> _$$GameWebsiteImplToJson(_$GameWebsiteImpl instance) =>
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
