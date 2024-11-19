import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/adapters.dart';

part 'game.freezed.dart';
part 'game.g.dart';

enum ScreenshotSize {
  thumb,
  full,
}

class ScheenshotSize {
  final String thumb;
  final String full;

  const ScheenshotSize({
    required this.thumb,
    required this.full,
  });
}

const IGDBScreenshotSize = ScheenshotSize(
  thumb: 't_thumb',
  full: 't_1080p',
);

const SteamScreenshotSize = ScheenshotSize(
  thumb: '600x338',
  full: '1920x1080',
);

@freezed
class GameDetails with _$GameDetails {
  const GameDetails._();

  @JsonSerializable(explicitToJson: true)
  const factory GameDetails({
    int? id,
    String? name,
    String? summary,
    String? storyline,
    String? url,
    int? first_release_date,
    IGDBCover? cover,
    @Default([]) List<GameScreenshot> screenshots,
    @Default([]) List<GameVideo> videos,
    @Default([]) List<GamePlatform> platforms,
    @Default([]) List<GameTheme> themes,
    @Default([]) List<GameWebsite> websites,
  }) = _GameDetails;

  factory GameDetails.fromJson(Map<String, Object?> json) =>
      _$GameDetailsFromJson(json);
}

@freezed
class GameScreenshot with _$GameScreenshot {
  const GameScreenshot._();

  const factory GameScreenshot({
    int? id,
    String? url,
  }) = _GameScreenshot;

  String getURL({
    ScreenshotSize size = ScreenshotSize.thumb,
  }) {
    if (url == null) {
      return '';
    }

    final String urlParsed = 'https:$url';

    if (urlParsed.contains('steamstatic') && size == ScreenshotSize.full) {
      return urlParsed.replaceAll(
        SteamScreenshotSize.thumb,
        SteamScreenshotSize.full,
      );
    }

    if (urlParsed.contains('igdb.com')) {
      if (size == ScreenshotSize.full) {
        return urlParsed.replaceAll(
          IGDBScreenshotSize.thumb,
          IGDBScreenshotSize.full,
        );
      }

      return urlParsed.replaceAll(
        IGDBScreenshotSize.thumb,
        't_screenshot_med',
      );
    }

    return urlParsed;
  }

  factory GameScreenshot.fromJson(Map<String, Object?> json) =>
      _$GameScreenshotFromJson(json);
}

@freezed
class GamePlatform with _$GamePlatform {
  const GamePlatform._();

  const factory GamePlatform({
    int? id,
    String? name,
    String? abbreviation,
  }) = _GamePlatform;

  factory GamePlatform.fromJson(Map<String, Object?> json) =>
      _$GamePlatformFromJson(json);
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
class GameTheme with _$GameTheme {
  const GameTheme._();

  const factory GameTheme({
    int? id,
    String? name,
  }) = _GameTheme;

  factory GameTheme.fromJson(Map<String, Object?> json) =>
      _$GameThemeFromJson(json);
}

@freezed
class GameVideo with _$GameVideo {
  const GameVideo._();

  const factory GameVideo({
    int? id,
    String? name,
    String? video_id,
  }) = _GameVideo;

  factory GameVideo.fromJson(Map<String, Object?> json) =>
      _$GameVideoFromJson(json);

  bool get isYouTube {
    return video_id != null && !video_id!.contains('http');
  }
}

@freezed
class GameWebsite with _$GameWebsite {
  const GameWebsite._();

  const factory GameWebsite({
    int? id,
    String? url,
  }) = _GameWebsite;

  factory GameWebsite.fromJson(Map<String, Object?> json) =>
      _$GameWebsiteFromJson(json);
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
