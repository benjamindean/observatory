import 'package:freezed_annotation/freezed_annotation.dart';

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

  const factory IGDBGame({
    int? id,
    String? name,
    String? slug,
    String? summary,
    String? storyline,
    String? url,
    IGDBCover? cover,
    @Default([]) List<IGDBScreenshot> screenshots,
    @Default([]) List<IGDBPlatform> platforms,
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
    ScreenshotSize size = ScreenshotSize.hd,
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
