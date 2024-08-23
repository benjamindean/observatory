// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GameDetails _$GameDetailsFromJson(Map<String, dynamic> json) {
  return _GameDetails.fromJson(json);
}

/// @nodoc
mixin _$GameDetails {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get summary => throw _privateConstructorUsedError;
  String? get storyline => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  int? get first_release_date => throw _privateConstructorUsedError;
  IGDBCover? get cover => throw _privateConstructorUsedError;
  List<GameScreenshot> get screenshots => throw _privateConstructorUsedError;
  List<GameVideo> get videos => throw _privateConstructorUsedError;
  List<GamePlatform> get platforms => throw _privateConstructorUsedError;
  List<GameTheme> get themes => throw _privateConstructorUsedError;
  List<GameWebsite> get websites => throw _privateConstructorUsedError;

  /// Serializes this GameDetails to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GameDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameDetailsCopyWith<GameDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameDetailsCopyWith<$Res> {
  factory $GameDetailsCopyWith(
          GameDetails value, $Res Function(GameDetails) then) =
      _$GameDetailsCopyWithImpl<$Res, GameDetails>;
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? summary,
      String? storyline,
      String? url,
      int? first_release_date,
      IGDBCover? cover,
      List<GameScreenshot> screenshots,
      List<GameVideo> videos,
      List<GamePlatform> platforms,
      List<GameTheme> themes,
      List<GameWebsite> websites});

  $IGDBCoverCopyWith<$Res>? get cover;
}

/// @nodoc
class _$GameDetailsCopyWithImpl<$Res, $Val extends GameDetails>
    implements $GameDetailsCopyWith<$Res> {
  _$GameDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? summary = freezed,
    Object? storyline = freezed,
    Object? url = freezed,
    Object? first_release_date = freezed,
    Object? cover = freezed,
    Object? screenshots = null,
    Object? videos = null,
    Object? platforms = null,
    Object? themes = null,
    Object? websites = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      summary: freezed == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String?,
      storyline: freezed == storyline
          ? _value.storyline
          : storyline // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      first_release_date: freezed == first_release_date
          ? _value.first_release_date
          : first_release_date // ignore: cast_nullable_to_non_nullable
              as int?,
      cover: freezed == cover
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as IGDBCover?,
      screenshots: null == screenshots
          ? _value.screenshots
          : screenshots // ignore: cast_nullable_to_non_nullable
              as List<GameScreenshot>,
      videos: null == videos
          ? _value.videos
          : videos // ignore: cast_nullable_to_non_nullable
              as List<GameVideo>,
      platforms: null == platforms
          ? _value.platforms
          : platforms // ignore: cast_nullable_to_non_nullable
              as List<GamePlatform>,
      themes: null == themes
          ? _value.themes
          : themes // ignore: cast_nullable_to_non_nullable
              as List<GameTheme>,
      websites: null == websites
          ? _value.websites
          : websites // ignore: cast_nullable_to_non_nullable
              as List<GameWebsite>,
    ) as $Val);
  }

  /// Create a copy of GameDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IGDBCoverCopyWith<$Res>? get cover {
    if (_value.cover == null) {
      return null;
    }

    return $IGDBCoverCopyWith<$Res>(_value.cover!, (value) {
      return _then(_value.copyWith(cover: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GameDetailsImplCopyWith<$Res>
    implements $GameDetailsCopyWith<$Res> {
  factory _$$GameDetailsImplCopyWith(
          _$GameDetailsImpl value, $Res Function(_$GameDetailsImpl) then) =
      __$$GameDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? summary,
      String? storyline,
      String? url,
      int? first_release_date,
      IGDBCover? cover,
      List<GameScreenshot> screenshots,
      List<GameVideo> videos,
      List<GamePlatform> platforms,
      List<GameTheme> themes,
      List<GameWebsite> websites});

  @override
  $IGDBCoverCopyWith<$Res>? get cover;
}

/// @nodoc
class __$$GameDetailsImplCopyWithImpl<$Res>
    extends _$GameDetailsCopyWithImpl<$Res, _$GameDetailsImpl>
    implements _$$GameDetailsImplCopyWith<$Res> {
  __$$GameDetailsImplCopyWithImpl(
      _$GameDetailsImpl _value, $Res Function(_$GameDetailsImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? summary = freezed,
    Object? storyline = freezed,
    Object? url = freezed,
    Object? first_release_date = freezed,
    Object? cover = freezed,
    Object? screenshots = null,
    Object? videos = null,
    Object? platforms = null,
    Object? themes = null,
    Object? websites = null,
  }) {
    return _then(_$GameDetailsImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      summary: freezed == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String?,
      storyline: freezed == storyline
          ? _value.storyline
          : storyline // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      first_release_date: freezed == first_release_date
          ? _value.first_release_date
          : first_release_date // ignore: cast_nullable_to_non_nullable
              as int?,
      cover: freezed == cover
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as IGDBCover?,
      screenshots: null == screenshots
          ? _value._screenshots
          : screenshots // ignore: cast_nullable_to_non_nullable
              as List<GameScreenshot>,
      videos: null == videos
          ? _value._videos
          : videos // ignore: cast_nullable_to_non_nullable
              as List<GameVideo>,
      platforms: null == platforms
          ? _value._platforms
          : platforms // ignore: cast_nullable_to_non_nullable
              as List<GamePlatform>,
      themes: null == themes
          ? _value._themes
          : themes // ignore: cast_nullable_to_non_nullable
              as List<GameTheme>,
      websites: null == websites
          ? _value._websites
          : websites // ignore: cast_nullable_to_non_nullable
              as List<GameWebsite>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$GameDetailsImpl extends _GameDetails {
  const _$GameDetailsImpl(
      {this.id,
      this.name,
      this.summary,
      this.storyline,
      this.url,
      this.first_release_date,
      this.cover,
      final List<GameScreenshot> screenshots = const [],
      final List<GameVideo> videos = const [],
      final List<GamePlatform> platforms = const [],
      final List<GameTheme> themes = const [],
      final List<GameWebsite> websites = const []})
      : _screenshots = screenshots,
        _videos = videos,
        _platforms = platforms,
        _themes = themes,
        _websites = websites,
        super._();

  factory _$GameDetailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameDetailsImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? summary;
  @override
  final String? storyline;
  @override
  final String? url;
  @override
  final int? first_release_date;
  @override
  final IGDBCover? cover;
  final List<GameScreenshot> _screenshots;
  @override
  @JsonKey()
  List<GameScreenshot> get screenshots {
    if (_screenshots is EqualUnmodifiableListView) return _screenshots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_screenshots);
  }

  final List<GameVideo> _videos;
  @override
  @JsonKey()
  List<GameVideo> get videos {
    if (_videos is EqualUnmodifiableListView) return _videos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_videos);
  }

  final List<GamePlatform> _platforms;
  @override
  @JsonKey()
  List<GamePlatform> get platforms {
    if (_platforms is EqualUnmodifiableListView) return _platforms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_platforms);
  }

  final List<GameTheme> _themes;
  @override
  @JsonKey()
  List<GameTheme> get themes {
    if (_themes is EqualUnmodifiableListView) return _themes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_themes);
  }

  final List<GameWebsite> _websites;
  @override
  @JsonKey()
  List<GameWebsite> get websites {
    if (_websites is EqualUnmodifiableListView) return _websites;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_websites);
  }

  @override
  String toString() {
    return 'GameDetails(id: $id, name: $name, summary: $summary, storyline: $storyline, url: $url, first_release_date: $first_release_date, cover: $cover, screenshots: $screenshots, videos: $videos, platforms: $platforms, themes: $themes, websites: $websites)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameDetailsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.storyline, storyline) ||
                other.storyline == storyline) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.first_release_date, first_release_date) ||
                other.first_release_date == first_release_date) &&
            (identical(other.cover, cover) || other.cover == cover) &&
            const DeepCollectionEquality()
                .equals(other._screenshots, _screenshots) &&
            const DeepCollectionEquality().equals(other._videos, _videos) &&
            const DeepCollectionEquality()
                .equals(other._platforms, _platforms) &&
            const DeepCollectionEquality().equals(other._themes, _themes) &&
            const DeepCollectionEquality().equals(other._websites, _websites));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      summary,
      storyline,
      url,
      first_release_date,
      cover,
      const DeepCollectionEquality().hash(_screenshots),
      const DeepCollectionEquality().hash(_videos),
      const DeepCollectionEquality().hash(_platforms),
      const DeepCollectionEquality().hash(_themes),
      const DeepCollectionEquality().hash(_websites));

  /// Create a copy of GameDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameDetailsImplCopyWith<_$GameDetailsImpl> get copyWith =>
      __$$GameDetailsImplCopyWithImpl<_$GameDetailsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameDetailsImplToJson(
      this,
    );
  }
}

abstract class _GameDetails extends GameDetails {
  const factory _GameDetails(
      {final int? id,
      final String? name,
      final String? summary,
      final String? storyline,
      final String? url,
      final int? first_release_date,
      final IGDBCover? cover,
      final List<GameScreenshot> screenshots,
      final List<GameVideo> videos,
      final List<GamePlatform> platforms,
      final List<GameTheme> themes,
      final List<GameWebsite> websites}) = _$GameDetailsImpl;
  const _GameDetails._() : super._();

  factory _GameDetails.fromJson(Map<String, dynamic> json) =
      _$GameDetailsImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get summary;
  @override
  String? get storyline;
  @override
  String? get url;
  @override
  int? get first_release_date;
  @override
  IGDBCover? get cover;
  @override
  List<GameScreenshot> get screenshots;
  @override
  List<GameVideo> get videos;
  @override
  List<GamePlatform> get platforms;
  @override
  List<GameTheme> get themes;
  @override
  List<GameWebsite> get websites;

  /// Create a copy of GameDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameDetailsImplCopyWith<_$GameDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GameScreenshot _$GameScreenshotFromJson(Map<String, dynamic> json) {
  return _GameScreenshot.fromJson(json);
}

/// @nodoc
mixin _$GameScreenshot {
  int? get id => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;

  /// Serializes this GameScreenshot to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GameScreenshot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameScreenshotCopyWith<GameScreenshot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameScreenshotCopyWith<$Res> {
  factory $GameScreenshotCopyWith(
          GameScreenshot value, $Res Function(GameScreenshot) then) =
      _$GameScreenshotCopyWithImpl<$Res, GameScreenshot>;
  @useResult
  $Res call({int? id, String? url});
}

/// @nodoc
class _$GameScreenshotCopyWithImpl<$Res, $Val extends GameScreenshot>
    implements $GameScreenshotCopyWith<$Res> {
  _$GameScreenshotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameScreenshot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameScreenshotImplCopyWith<$Res>
    implements $GameScreenshotCopyWith<$Res> {
  factory _$$GameScreenshotImplCopyWith(_$GameScreenshotImpl value,
          $Res Function(_$GameScreenshotImpl) then) =
      __$$GameScreenshotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? url});
}

/// @nodoc
class __$$GameScreenshotImplCopyWithImpl<$Res>
    extends _$GameScreenshotCopyWithImpl<$Res, _$GameScreenshotImpl>
    implements _$$GameScreenshotImplCopyWith<$Res> {
  __$$GameScreenshotImplCopyWithImpl(
      _$GameScreenshotImpl _value, $Res Function(_$GameScreenshotImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameScreenshot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? url = freezed,
  }) {
    return _then(_$GameScreenshotImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameScreenshotImpl extends _GameScreenshot {
  const _$GameScreenshotImpl({this.id, this.url}) : super._();

  factory _$GameScreenshotImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameScreenshotImplFromJson(json);

  @override
  final int? id;
  @override
  final String? url;

  @override
  String toString() {
    return 'GameScreenshot(id: $id, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameScreenshotImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, url);

  /// Create a copy of GameScreenshot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameScreenshotImplCopyWith<_$GameScreenshotImpl> get copyWith =>
      __$$GameScreenshotImplCopyWithImpl<_$GameScreenshotImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameScreenshotImplToJson(
      this,
    );
  }
}

abstract class _GameScreenshot extends GameScreenshot {
  const factory _GameScreenshot({final int? id, final String? url}) =
      _$GameScreenshotImpl;
  const _GameScreenshot._() : super._();

  factory _GameScreenshot.fromJson(Map<String, dynamic> json) =
      _$GameScreenshotImpl.fromJson;

  @override
  int? get id;
  @override
  String? get url;

  /// Create a copy of GameScreenshot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameScreenshotImplCopyWith<_$GameScreenshotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GamePlatform _$GamePlatformFromJson(Map<String, dynamic> json) {
  return _GamePlatform.fromJson(json);
}

/// @nodoc
mixin _$GamePlatform {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get abbreviation => throw _privateConstructorUsedError;

  /// Serializes this GamePlatform to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GamePlatform
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GamePlatformCopyWith<GamePlatform> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GamePlatformCopyWith<$Res> {
  factory $GamePlatformCopyWith(
          GamePlatform value, $Res Function(GamePlatform) then) =
      _$GamePlatformCopyWithImpl<$Res, GamePlatform>;
  @useResult
  $Res call({int? id, String? name, String? abbreviation});
}

/// @nodoc
class _$GamePlatformCopyWithImpl<$Res, $Val extends GamePlatform>
    implements $GamePlatformCopyWith<$Res> {
  _$GamePlatformCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GamePlatform
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? abbreviation = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      abbreviation: freezed == abbreviation
          ? _value.abbreviation
          : abbreviation // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GamePlatformImplCopyWith<$Res>
    implements $GamePlatformCopyWith<$Res> {
  factory _$$GamePlatformImplCopyWith(
          _$GamePlatformImpl value, $Res Function(_$GamePlatformImpl) then) =
      __$$GamePlatformImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? name, String? abbreviation});
}

/// @nodoc
class __$$GamePlatformImplCopyWithImpl<$Res>
    extends _$GamePlatformCopyWithImpl<$Res, _$GamePlatformImpl>
    implements _$$GamePlatformImplCopyWith<$Res> {
  __$$GamePlatformImplCopyWithImpl(
      _$GamePlatformImpl _value, $Res Function(_$GamePlatformImpl) _then)
      : super(_value, _then);

  /// Create a copy of GamePlatform
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? abbreviation = freezed,
  }) {
    return _then(_$GamePlatformImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      abbreviation: freezed == abbreviation
          ? _value.abbreviation
          : abbreviation // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GamePlatformImpl extends _GamePlatform {
  const _$GamePlatformImpl({this.id, this.name, this.abbreviation}) : super._();

  factory _$GamePlatformImpl.fromJson(Map<String, dynamic> json) =>
      _$$GamePlatformImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? abbreviation;

  @override
  String toString() {
    return 'GamePlatform(id: $id, name: $name, abbreviation: $abbreviation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GamePlatformImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.abbreviation, abbreviation) ||
                other.abbreviation == abbreviation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, abbreviation);

  /// Create a copy of GamePlatform
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GamePlatformImplCopyWith<_$GamePlatformImpl> get copyWith =>
      __$$GamePlatformImplCopyWithImpl<_$GamePlatformImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GamePlatformImplToJson(
      this,
    );
  }
}

abstract class _GamePlatform extends GamePlatform {
  const factory _GamePlatform(
      {final int? id,
      final String? name,
      final String? abbreviation}) = _$GamePlatformImpl;
  const _GamePlatform._() : super._();

  factory _GamePlatform.fromJson(Map<String, dynamic> json) =
      _$GamePlatformImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get abbreviation;

  /// Create a copy of GamePlatform
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GamePlatformImplCopyWith<_$GamePlatformImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IGDBCover _$IGDBCoverFromJson(Map<String, dynamic> json) {
  return _IGDBCover.fromJson(json);
}

/// @nodoc
mixin _$IGDBCover {
  int? get id => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;

  /// Serializes this IGDBCover to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IGDBCover
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IGDBCoverCopyWith<IGDBCover> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IGDBCoverCopyWith<$Res> {
  factory $IGDBCoverCopyWith(IGDBCover value, $Res Function(IGDBCover) then) =
      _$IGDBCoverCopyWithImpl<$Res, IGDBCover>;
  @useResult
  $Res call({int? id, String? url});
}

/// @nodoc
class _$IGDBCoverCopyWithImpl<$Res, $Val extends IGDBCover>
    implements $IGDBCoverCopyWith<$Res> {
  _$IGDBCoverCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IGDBCover
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IGDBCoverImplCopyWith<$Res>
    implements $IGDBCoverCopyWith<$Res> {
  factory _$$IGDBCoverImplCopyWith(
          _$IGDBCoverImpl value, $Res Function(_$IGDBCoverImpl) then) =
      __$$IGDBCoverImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? url});
}

/// @nodoc
class __$$IGDBCoverImplCopyWithImpl<$Res>
    extends _$IGDBCoverCopyWithImpl<$Res, _$IGDBCoverImpl>
    implements _$$IGDBCoverImplCopyWith<$Res> {
  __$$IGDBCoverImplCopyWithImpl(
      _$IGDBCoverImpl _value, $Res Function(_$IGDBCoverImpl) _then)
      : super(_value, _then);

  /// Create a copy of IGDBCover
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? url = freezed,
  }) {
    return _then(_$IGDBCoverImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IGDBCoverImpl extends _IGDBCover {
  const _$IGDBCoverImpl({this.id, this.url}) : super._();

  factory _$IGDBCoverImpl.fromJson(Map<String, dynamic> json) =>
      _$$IGDBCoverImplFromJson(json);

  @override
  final int? id;
  @override
  final String? url;

  @override
  String toString() {
    return 'IGDBCover(id: $id, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IGDBCoverImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, url);

  /// Create a copy of IGDBCover
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IGDBCoverImplCopyWith<_$IGDBCoverImpl> get copyWith =>
      __$$IGDBCoverImplCopyWithImpl<_$IGDBCoverImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IGDBCoverImplToJson(
      this,
    );
  }
}

abstract class _IGDBCover extends IGDBCover {
  const factory _IGDBCover({final int? id, final String? url}) =
      _$IGDBCoverImpl;
  const _IGDBCover._() : super._();

  factory _IGDBCover.fromJson(Map<String, dynamic> json) =
      _$IGDBCoverImpl.fromJson;

  @override
  int? get id;
  @override
  String? get url;

  /// Create a copy of IGDBCover
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IGDBCoverImplCopyWith<_$IGDBCoverImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GameTheme _$GameThemeFromJson(Map<String, dynamic> json) {
  return _GameTheme.fromJson(json);
}

/// @nodoc
mixin _$GameTheme {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  /// Serializes this GameTheme to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GameTheme
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameThemeCopyWith<GameTheme> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameThemeCopyWith<$Res> {
  factory $GameThemeCopyWith(GameTheme value, $Res Function(GameTheme) then) =
      _$GameThemeCopyWithImpl<$Res, GameTheme>;
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class _$GameThemeCopyWithImpl<$Res, $Val extends GameTheme>
    implements $GameThemeCopyWith<$Res> {
  _$GameThemeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameTheme
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameThemeImplCopyWith<$Res>
    implements $GameThemeCopyWith<$Res> {
  factory _$$GameThemeImplCopyWith(
          _$GameThemeImpl value, $Res Function(_$GameThemeImpl) then) =
      __$$GameThemeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class __$$GameThemeImplCopyWithImpl<$Res>
    extends _$GameThemeCopyWithImpl<$Res, _$GameThemeImpl>
    implements _$$GameThemeImplCopyWith<$Res> {
  __$$GameThemeImplCopyWithImpl(
      _$GameThemeImpl _value, $Res Function(_$GameThemeImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameTheme
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_$GameThemeImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameThemeImpl extends _GameTheme {
  const _$GameThemeImpl({this.id, this.name}) : super._();

  factory _$GameThemeImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameThemeImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;

  @override
  String toString() {
    return 'GameTheme(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameThemeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of GameTheme
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameThemeImplCopyWith<_$GameThemeImpl> get copyWith =>
      __$$GameThemeImplCopyWithImpl<_$GameThemeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameThemeImplToJson(
      this,
    );
  }
}

abstract class _GameTheme extends GameTheme {
  const factory _GameTheme({final int? id, final String? name}) =
      _$GameThemeImpl;
  const _GameTheme._() : super._();

  factory _GameTheme.fromJson(Map<String, dynamic> json) =
      _$GameThemeImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;

  /// Create a copy of GameTheme
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameThemeImplCopyWith<_$GameThemeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GameVideo _$GameVideoFromJson(Map<String, dynamic> json) {
  return _GameVideo.fromJson(json);
}

/// @nodoc
mixin _$GameVideo {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get video_id => throw _privateConstructorUsedError;

  /// Serializes this GameVideo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GameVideo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameVideoCopyWith<GameVideo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameVideoCopyWith<$Res> {
  factory $GameVideoCopyWith(GameVideo value, $Res Function(GameVideo) then) =
      _$GameVideoCopyWithImpl<$Res, GameVideo>;
  @useResult
  $Res call({int? id, String? name, String? video_id});
}

/// @nodoc
class _$GameVideoCopyWithImpl<$Res, $Val extends GameVideo>
    implements $GameVideoCopyWith<$Res> {
  _$GameVideoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameVideo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? video_id = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      video_id: freezed == video_id
          ? _value.video_id
          : video_id // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameVideoImplCopyWith<$Res>
    implements $GameVideoCopyWith<$Res> {
  factory _$$GameVideoImplCopyWith(
          _$GameVideoImpl value, $Res Function(_$GameVideoImpl) then) =
      __$$GameVideoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? name, String? video_id});
}

/// @nodoc
class __$$GameVideoImplCopyWithImpl<$Res>
    extends _$GameVideoCopyWithImpl<$Res, _$GameVideoImpl>
    implements _$$GameVideoImplCopyWith<$Res> {
  __$$GameVideoImplCopyWithImpl(
      _$GameVideoImpl _value, $Res Function(_$GameVideoImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameVideo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? video_id = freezed,
  }) {
    return _then(_$GameVideoImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      video_id: freezed == video_id
          ? _value.video_id
          : video_id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameVideoImpl extends _GameVideo {
  const _$GameVideoImpl({this.id, this.name, this.video_id}) : super._();

  factory _$GameVideoImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameVideoImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? video_id;

  @override
  String toString() {
    return 'GameVideo(id: $id, name: $name, video_id: $video_id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameVideoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.video_id, video_id) ||
                other.video_id == video_id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, video_id);

  /// Create a copy of GameVideo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameVideoImplCopyWith<_$GameVideoImpl> get copyWith =>
      __$$GameVideoImplCopyWithImpl<_$GameVideoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameVideoImplToJson(
      this,
    );
  }
}

abstract class _GameVideo extends GameVideo {
  const factory _GameVideo(
      {final int? id,
      final String? name,
      final String? video_id}) = _$GameVideoImpl;
  const _GameVideo._() : super._();

  factory _GameVideo.fromJson(Map<String, dynamic> json) =
      _$GameVideoImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get video_id;

  /// Create a copy of GameVideo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameVideoImplCopyWith<_$GameVideoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GameWebsite _$GameWebsiteFromJson(Map<String, dynamic> json) {
  return _GameWebsite.fromJson(json);
}

/// @nodoc
mixin _$GameWebsite {
  int? get id => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;

  /// Serializes this GameWebsite to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GameWebsite
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameWebsiteCopyWith<GameWebsite> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameWebsiteCopyWith<$Res> {
  factory $GameWebsiteCopyWith(
          GameWebsite value, $Res Function(GameWebsite) then) =
      _$GameWebsiteCopyWithImpl<$Res, GameWebsite>;
  @useResult
  $Res call({int? id, String? url});
}

/// @nodoc
class _$GameWebsiteCopyWithImpl<$Res, $Val extends GameWebsite>
    implements $GameWebsiteCopyWith<$Res> {
  _$GameWebsiteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameWebsite
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameWebsiteImplCopyWith<$Res>
    implements $GameWebsiteCopyWith<$Res> {
  factory _$$GameWebsiteImplCopyWith(
          _$GameWebsiteImpl value, $Res Function(_$GameWebsiteImpl) then) =
      __$$GameWebsiteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? url});
}

/// @nodoc
class __$$GameWebsiteImplCopyWithImpl<$Res>
    extends _$GameWebsiteCopyWithImpl<$Res, _$GameWebsiteImpl>
    implements _$$GameWebsiteImplCopyWith<$Res> {
  __$$GameWebsiteImplCopyWithImpl(
      _$GameWebsiteImpl _value, $Res Function(_$GameWebsiteImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameWebsite
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? url = freezed,
  }) {
    return _then(_$GameWebsiteImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameWebsiteImpl extends _GameWebsite {
  const _$GameWebsiteImpl({this.id, this.url}) : super._();

  factory _$GameWebsiteImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameWebsiteImplFromJson(json);

  @override
  final int? id;
  @override
  final String? url;

  @override
  String toString() {
    return 'GameWebsite(id: $id, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameWebsiteImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, url);

  /// Create a copy of GameWebsite
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameWebsiteImplCopyWith<_$GameWebsiteImpl> get copyWith =>
      __$$GameWebsiteImplCopyWithImpl<_$GameWebsiteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameWebsiteImplToJson(
      this,
    );
  }
}

abstract class _GameWebsite extends GameWebsite {
  const factory _GameWebsite({final int? id, final String? url}) =
      _$GameWebsiteImpl;
  const _GameWebsite._() : super._();

  factory _GameWebsite.fromJson(Map<String, dynamic> json) =
      _$GameWebsiteImpl.fromJson;

  @override
  int? get id;
  @override
  String? get url;

  /// Create a copy of GameWebsite
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameWebsiteImplCopyWith<_$GameWebsiteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IGDBAccessToken _$IGDBAccessTokenFromJson(Map<String, dynamic> json) {
  return _IGDBAccessToken.fromJson(json);
}

/// @nodoc
mixin _$IGDBAccessToken {
  @HiveField(0)
  String? get token => throw _privateConstructorUsedError;
  @HiveField(1)
  int get expires_at => throw _privateConstructorUsedError;

  /// Serializes this IGDBAccessToken to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IGDBAccessToken
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IGDBAccessTokenCopyWith<IGDBAccessToken> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IGDBAccessTokenCopyWith<$Res> {
  factory $IGDBAccessTokenCopyWith(
          IGDBAccessToken value, $Res Function(IGDBAccessToken) then) =
      _$IGDBAccessTokenCopyWithImpl<$Res, IGDBAccessToken>;
  @useResult
  $Res call({@HiveField(0) String? token, @HiveField(1) int expires_at});
}

/// @nodoc
class _$IGDBAccessTokenCopyWithImpl<$Res, $Val extends IGDBAccessToken>
    implements $IGDBAccessTokenCopyWith<$Res> {
  _$IGDBAccessTokenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IGDBAccessToken
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = freezed,
    Object? expires_at = null,
  }) {
    return _then(_value.copyWith(
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      expires_at: null == expires_at
          ? _value.expires_at
          : expires_at // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IGDBAccessTokenImplCopyWith<$Res>
    implements $IGDBAccessTokenCopyWith<$Res> {
  factory _$$IGDBAccessTokenImplCopyWith(_$IGDBAccessTokenImpl value,
          $Res Function(_$IGDBAccessTokenImpl) then) =
      __$$IGDBAccessTokenImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@HiveField(0) String? token, @HiveField(1) int expires_at});
}

/// @nodoc
class __$$IGDBAccessTokenImplCopyWithImpl<$Res>
    extends _$IGDBAccessTokenCopyWithImpl<$Res, _$IGDBAccessTokenImpl>
    implements _$$IGDBAccessTokenImplCopyWith<$Res> {
  __$$IGDBAccessTokenImplCopyWithImpl(
      _$IGDBAccessTokenImpl _value, $Res Function(_$IGDBAccessTokenImpl) _then)
      : super(_value, _then);

  /// Create a copy of IGDBAccessToken
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = freezed,
    Object? expires_at = null,
  }) {
    return _then(_$IGDBAccessTokenImpl(
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      expires_at: null == expires_at
          ? _value.expires_at
          : expires_at // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IGDBAccessTokenImpl extends _IGDBAccessToken {
  const _$IGDBAccessTokenImpl(
      {@HiveField(0) this.token, @HiveField(1) this.expires_at = 0})
      : super._();

  factory _$IGDBAccessTokenImpl.fromJson(Map<String, dynamic> json) =>
      _$$IGDBAccessTokenImplFromJson(json);

  @override
  @HiveField(0)
  final String? token;
  @override
  @JsonKey()
  @HiveField(1)
  final int expires_at;

  @override
  String toString() {
    return 'IGDBAccessToken(token: $token, expires_at: $expires_at)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IGDBAccessTokenImpl &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.expires_at, expires_at) ||
                other.expires_at == expires_at));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, token, expires_at);

  /// Create a copy of IGDBAccessToken
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IGDBAccessTokenImplCopyWith<_$IGDBAccessTokenImpl> get copyWith =>
      __$$IGDBAccessTokenImplCopyWithImpl<_$IGDBAccessTokenImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IGDBAccessTokenImplToJson(
      this,
    );
  }
}

abstract class _IGDBAccessToken extends IGDBAccessToken {
  const factory _IGDBAccessToken(
      {@HiveField(0) final String? token,
      @HiveField(1) final int expires_at}) = _$IGDBAccessTokenImpl;
  const _IGDBAccessToken._() : super._();

  factory _IGDBAccessToken.fromJson(Map<String, dynamic> json) =
      _$IGDBAccessTokenImpl.fromJson;

  @override
  @HiveField(0)
  String? get token;
  @override
  @HiveField(1)
  int get expires_at;

  /// Create a copy of IGDBAccessToken
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IGDBAccessTokenImplCopyWith<_$IGDBAccessTokenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
