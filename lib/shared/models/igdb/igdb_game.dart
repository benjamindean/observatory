import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/adapters.dart';

part 'igdb_game.freezed.dart';
part 'igdb_game.g.dart';

enum ScreenshotSize {
  med('screenshot_med'),
  big('screenshot_big'),
  huge('screenshot_huge'),
  hd('720p'),
  fullHD('1080p');

  const ScreenshotSize(this.value);

  final String value;
}

enum Foo {
  one(1),
  two(2);

  const Foo(this.value);
  final num value;
}

@freezed
class IGDBGame with _$IGDBGame {
  const IGDBGame._();

  @JsonSerializable(explicitToJson: true)
  const factory IGDBGame({
    int? id,
    String? name,
    String? summary,
    String? storyline,
    String? url,
    int? first_release_date,
    IGDBCover? cover,
    @Default([]) List<IGDBScreenshot> screenshots,
    @Default([]) List<IGDBVideo> videos,
    @Default([]) List<IGDBPlatform> platforms,
    @Default([]) List<IGDBTheme> themes,
    @Default([]) List<IGDBWebsite> websites,
  }) = _IGDBGame;

  factory IGDBGame.fromJson(Map<String, Object?> json) =>
      _$IGDBGameFromJson(json);
}

@freezed
class IGDBScreenshot with _$IGDBScreenshot {
  const IGDBScreenshot._();

  const factory IGDBScreenshot({
    int? id,
    String? url,
  }) = _IGDBScreenshot;

  String? getURL({
    ScreenshotSize size = ScreenshotSize.med,
  }) {
    if (url == null) return null;

    return 'https:${url?.replaceAll('t_thumb', 't_${size.value}')}';
  }

  factory IGDBScreenshot.fromJson(Map<String, Object?> json) =>
      _$IGDBScreenshotFromJson(json);
}

@freezed
class IGDBPlatform with _$IGDBPlatform {
  const IGDBPlatform._();

  const factory IGDBPlatform({
    int? id,
    String? name,
    String? abbreviation,
  }) = _IGDBPlatform;

  factory IGDBPlatform.fromJson(Map<String, Object?> json) =>
      _$IGDBPlatformFromJson(json);
}

@freezed
class IGDBCover with _$IGDBCover {
  const IGDBCover._();

  const factory IGDBCover({
    int? id,
    String? url,
  }) = _IGDBCover;

  factory IGDBCover.fromJson(Map<String, Object?> json) =>
      _$IGDBCoverFromJson(json);
}

@freezed
class IGDBTheme with _$IGDBTheme {
  const IGDBTheme._();

  const factory IGDBTheme({
    int? id,
    String? name,
  }) = _IGDBTheme;

  factory IGDBTheme.fromJson(Map<String, Object?> json) =>
      _$IGDBThemeFromJson(json);
}

@freezed
class IGDBVideo with _$IGDBVideo {
  const IGDBVideo._();

  const factory IGDBVideo({
    int? id,
    String? name,
    String? video_id,
  }) = _IGDBVideo;

  factory IGDBVideo.fromJson(Map<String, Object?> json) =>
      _$IGDBVideoFromJson(json);
}

@freezed
class IGDBWebsite with _$IGDBWebsite {
  const IGDBWebsite._();

  const factory IGDBWebsite({
    int? id,
    String? url,
  }) = _IGDBWebsite;

  factory IGDBWebsite.fromJson(Map<String, Object?> json) =>
      _$IGDBWebsiteFromJson(json);
}

@freezed
@HiveType(typeId: 7)
class IGDBAccessToken with _$IGDBAccessToken {
  const IGDBAccessToken._();

  const factory IGDBAccessToken({
    @HiveField(0) String? token,
    @HiveField(1) @Default(0) int expires_at,
  }) = _IGDBAccessToken;

  factory IGDBAccessToken.fromJson(Map<String, Object?> json) =>
      _$IGDBAccessTokenFromJson(json);
}
