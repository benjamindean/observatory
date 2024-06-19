// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'igdb_game.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

IGDBGame _$IGDBGameFromJson(Map<String, dynamic> json) {
  return _IGDBGame.fromJson(json);
}

/// @nodoc
mixin _$IGDBGame {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get summary => throw _privateConstructorUsedError;
  String? get storyline => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  int? get first_release_date => throw _privateConstructorUsedError;
  IGDBCover? get cover => throw _privateConstructorUsedError;
  List<IGDBScreenshot> get screenshots => throw _privateConstructorUsedError;
  List<IGDBVideo> get videos => throw _privateConstructorUsedError;
  List<IGDBPlatform> get platforms => throw _privateConstructorUsedError;
  List<IGDBTheme> get themes => throw _privateConstructorUsedError;
  List<IGDBWebsite> get websites => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IGDBGameCopyWith<IGDBGame> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IGDBGameCopyWith<$Res> {
  factory $IGDBGameCopyWith(IGDBGame value, $Res Function(IGDBGame) then) =
      _$IGDBGameCopyWithImpl<$Res, IGDBGame>;
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? summary,
      String? storyline,
      String? url,
      int? first_release_date,
      IGDBCover? cover,
      List<IGDBScreenshot> screenshots,
      List<IGDBVideo> videos,
      List<IGDBPlatform> platforms,
      List<IGDBTheme> themes,
      List<IGDBWebsite> websites});

  $IGDBCoverCopyWith<$Res>? get cover;
}

/// @nodoc
class _$IGDBGameCopyWithImpl<$Res, $Val extends IGDBGame>
    implements $IGDBGameCopyWith<$Res> {
  _$IGDBGameCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
              as List<IGDBScreenshot>,
      videos: null == videos
          ? _value.videos
          : videos // ignore: cast_nullable_to_non_nullable
              as List<IGDBVideo>,
      platforms: null == platforms
          ? _value.platforms
          : platforms // ignore: cast_nullable_to_non_nullable
              as List<IGDBPlatform>,
      themes: null == themes
          ? _value.themes
          : themes // ignore: cast_nullable_to_non_nullable
              as List<IGDBTheme>,
      websites: null == websites
          ? _value.websites
          : websites // ignore: cast_nullable_to_non_nullable
              as List<IGDBWebsite>,
    ) as $Val);
  }

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
abstract class _$$IGDBGameImplCopyWith<$Res>
    implements $IGDBGameCopyWith<$Res> {
  factory _$$IGDBGameImplCopyWith(
          _$IGDBGameImpl value, $Res Function(_$IGDBGameImpl) then) =
      __$$IGDBGameImplCopyWithImpl<$Res>;
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
      List<IGDBScreenshot> screenshots,
      List<IGDBVideo> videos,
      List<IGDBPlatform> platforms,
      List<IGDBTheme> themes,
      List<IGDBWebsite> websites});

  @override
  $IGDBCoverCopyWith<$Res>? get cover;
}

/// @nodoc
class __$$IGDBGameImplCopyWithImpl<$Res>
    extends _$IGDBGameCopyWithImpl<$Res, _$IGDBGameImpl>
    implements _$$IGDBGameImplCopyWith<$Res> {
  __$$IGDBGameImplCopyWithImpl(
      _$IGDBGameImpl _value, $Res Function(_$IGDBGameImpl) _then)
      : super(_value, _then);

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
    return _then(_$IGDBGameImpl(
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
              as List<IGDBScreenshot>,
      videos: null == videos
          ? _value._videos
          : videos // ignore: cast_nullable_to_non_nullable
              as List<IGDBVideo>,
      platforms: null == platforms
          ? _value._platforms
          : platforms // ignore: cast_nullable_to_non_nullable
              as List<IGDBPlatform>,
      themes: null == themes
          ? _value._themes
          : themes // ignore: cast_nullable_to_non_nullable
              as List<IGDBTheme>,
      websites: null == websites
          ? _value._websites
          : websites // ignore: cast_nullable_to_non_nullable
              as List<IGDBWebsite>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$IGDBGameImpl extends _IGDBGame {
  const _$IGDBGameImpl(
      {this.id,
      this.name,
      this.summary,
      this.storyline,
      this.url,
      this.first_release_date,
      this.cover,
      final List<IGDBScreenshot> screenshots = const [],
      final List<IGDBVideo> videos = const [],
      final List<IGDBPlatform> platforms = const [],
      final List<IGDBTheme> themes = const [],
      final List<IGDBWebsite> websites = const []})
      : _screenshots = screenshots,
        _videos = videos,
        _platforms = platforms,
        _themes = themes,
        _websites = websites,
        super._();

  factory _$IGDBGameImpl.fromJson(Map<String, dynamic> json) =>
      _$$IGDBGameImplFromJson(json);

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
  final List<IGDBScreenshot> _screenshots;
  @override
  @JsonKey()
  List<IGDBScreenshot> get screenshots {
    if (_screenshots is EqualUnmodifiableListView) return _screenshots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_screenshots);
  }

  final List<IGDBVideo> _videos;
  @override
  @JsonKey()
  List<IGDBVideo> get videos {
    if (_videos is EqualUnmodifiableListView) return _videos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_videos);
  }

  final List<IGDBPlatform> _platforms;
  @override
  @JsonKey()
  List<IGDBPlatform> get platforms {
    if (_platforms is EqualUnmodifiableListView) return _platforms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_platforms);
  }

  final List<IGDBTheme> _themes;
  @override
  @JsonKey()
  List<IGDBTheme> get themes {
    if (_themes is EqualUnmodifiableListView) return _themes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_themes);
  }

  final List<IGDBWebsite> _websites;
  @override
  @JsonKey()
  List<IGDBWebsite> get websites {
    if (_websites is EqualUnmodifiableListView) return _websites;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_websites);
  }

  @override
  String toString() {
    return 'IGDBGame(id: $id, name: $name, summary: $summary, storyline: $storyline, url: $url, first_release_date: $first_release_date, cover: $cover, screenshots: $screenshots, videos: $videos, platforms: $platforms, themes: $themes, websites: $websites)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IGDBGameImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IGDBGameImplCopyWith<_$IGDBGameImpl> get copyWith =>
      __$$IGDBGameImplCopyWithImpl<_$IGDBGameImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IGDBGameImplToJson(
      this,
    );
  }
}

abstract class _IGDBGame extends IGDBGame {
  const factory _IGDBGame(
      {final int? id,
      final String? name,
      final String? summary,
      final String? storyline,
      final String? url,
      final int? first_release_date,
      final IGDBCover? cover,
      final List<IGDBScreenshot> screenshots,
      final List<IGDBVideo> videos,
      final List<IGDBPlatform> platforms,
      final List<IGDBTheme> themes,
      final List<IGDBWebsite> websites}) = _$IGDBGameImpl;
  const _IGDBGame._() : super._();

  factory _IGDBGame.fromJson(Map<String, dynamic> json) =
      _$IGDBGameImpl.fromJson;

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
  List<IGDBScreenshot> get screenshots;
  @override
  List<IGDBVideo> get videos;
  @override
  List<IGDBPlatform> get platforms;
  @override
  List<IGDBTheme> get themes;
  @override
  List<IGDBWebsite> get websites;
  @override
  @JsonKey(ignore: true)
  _$$IGDBGameImplCopyWith<_$IGDBGameImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IGDBScreenshot _$IGDBScreenshotFromJson(Map<String, dynamic> json) {
  return _IGDBScreenshot.fromJson(json);
}

/// @nodoc
mixin _$IGDBScreenshot {
  int? get id => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IGDBScreenshotCopyWith<IGDBScreenshot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IGDBScreenshotCopyWith<$Res> {
  factory $IGDBScreenshotCopyWith(
          IGDBScreenshot value, $Res Function(IGDBScreenshot) then) =
      _$IGDBScreenshotCopyWithImpl<$Res, IGDBScreenshot>;
  @useResult
  $Res call({int? id, String? url});
}

/// @nodoc
class _$IGDBScreenshotCopyWithImpl<$Res, $Val extends IGDBScreenshot>
    implements $IGDBScreenshotCopyWith<$Res> {
  _$IGDBScreenshotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
abstract class _$$IGDBScreenshotImplCopyWith<$Res>
    implements $IGDBScreenshotCopyWith<$Res> {
  factory _$$IGDBScreenshotImplCopyWith(_$IGDBScreenshotImpl value,
          $Res Function(_$IGDBScreenshotImpl) then) =
      __$$IGDBScreenshotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? url});
}

/// @nodoc
class __$$IGDBScreenshotImplCopyWithImpl<$Res>
    extends _$IGDBScreenshotCopyWithImpl<$Res, _$IGDBScreenshotImpl>
    implements _$$IGDBScreenshotImplCopyWith<$Res> {
  __$$IGDBScreenshotImplCopyWithImpl(
      _$IGDBScreenshotImpl _value, $Res Function(_$IGDBScreenshotImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? url = freezed,
  }) {
    return _then(_$IGDBScreenshotImpl(
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
class _$IGDBScreenshotImpl extends _IGDBScreenshot {
  const _$IGDBScreenshotImpl({this.id, this.url}) : super._();

  factory _$IGDBScreenshotImpl.fromJson(Map<String, dynamic> json) =>
      _$$IGDBScreenshotImplFromJson(json);

  @override
  final int? id;
  @override
  final String? url;

  @override
  String toString() {
    return 'IGDBScreenshot(id: $id, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IGDBScreenshotImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IGDBScreenshotImplCopyWith<_$IGDBScreenshotImpl> get copyWith =>
      __$$IGDBScreenshotImplCopyWithImpl<_$IGDBScreenshotImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IGDBScreenshotImplToJson(
      this,
    );
  }
}

abstract class _IGDBScreenshot extends IGDBScreenshot {
  const factory _IGDBScreenshot({final int? id, final String? url}) =
      _$IGDBScreenshotImpl;
  const _IGDBScreenshot._() : super._();

  factory _IGDBScreenshot.fromJson(Map<String, dynamic> json) =
      _$IGDBScreenshotImpl.fromJson;

  @override
  int? get id;
  @override
  String? get url;
  @override
  @JsonKey(ignore: true)
  _$$IGDBScreenshotImplCopyWith<_$IGDBScreenshotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IGDBPlatform _$IGDBPlatformFromJson(Map<String, dynamic> json) {
  return _IGDBPlatform.fromJson(json);
}

/// @nodoc
mixin _$IGDBPlatform {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get abbreviation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IGDBPlatformCopyWith<IGDBPlatform> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IGDBPlatformCopyWith<$Res> {
  factory $IGDBPlatformCopyWith(
          IGDBPlatform value, $Res Function(IGDBPlatform) then) =
      _$IGDBPlatformCopyWithImpl<$Res, IGDBPlatform>;
  @useResult
  $Res call({int? id, String? name, String? abbreviation});
}

/// @nodoc
class _$IGDBPlatformCopyWithImpl<$Res, $Val extends IGDBPlatform>
    implements $IGDBPlatformCopyWith<$Res> {
  _$IGDBPlatformCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
abstract class _$$IGDBPlatformImplCopyWith<$Res>
    implements $IGDBPlatformCopyWith<$Res> {
  factory _$$IGDBPlatformImplCopyWith(
          _$IGDBPlatformImpl value, $Res Function(_$IGDBPlatformImpl) then) =
      __$$IGDBPlatformImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? name, String? abbreviation});
}

/// @nodoc
class __$$IGDBPlatformImplCopyWithImpl<$Res>
    extends _$IGDBPlatformCopyWithImpl<$Res, _$IGDBPlatformImpl>
    implements _$$IGDBPlatformImplCopyWith<$Res> {
  __$$IGDBPlatformImplCopyWithImpl(
      _$IGDBPlatformImpl _value, $Res Function(_$IGDBPlatformImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? abbreviation = freezed,
  }) {
    return _then(_$IGDBPlatformImpl(
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
class _$IGDBPlatformImpl extends _IGDBPlatform {
  const _$IGDBPlatformImpl({this.id, this.name, this.abbreviation}) : super._();

  factory _$IGDBPlatformImpl.fromJson(Map<String, dynamic> json) =>
      _$$IGDBPlatformImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? abbreviation;

  @override
  String toString() {
    return 'IGDBPlatform(id: $id, name: $name, abbreviation: $abbreviation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IGDBPlatformImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.abbreviation, abbreviation) ||
                other.abbreviation == abbreviation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, abbreviation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IGDBPlatformImplCopyWith<_$IGDBPlatformImpl> get copyWith =>
      __$$IGDBPlatformImplCopyWithImpl<_$IGDBPlatformImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IGDBPlatformImplToJson(
      this,
    );
  }
}

abstract class _IGDBPlatform extends IGDBPlatform {
  const factory _IGDBPlatform(
      {final int? id,
      final String? name,
      final String? abbreviation}) = _$IGDBPlatformImpl;
  const _IGDBPlatform._() : super._();

  factory _IGDBPlatform.fromJson(Map<String, dynamic> json) =
      _$IGDBPlatformImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get abbreviation;
  @override
  @JsonKey(ignore: true)
  _$$IGDBPlatformImplCopyWith<_$IGDBPlatformImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IGDBCover _$IGDBCoverFromJson(Map<String, dynamic> json) {
  return _IGDBCover.fromJson(json);
}

/// @nodoc
mixin _$IGDBCover {
  int? get id => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, url);

  @JsonKey(ignore: true)
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
  @override
  @JsonKey(ignore: true)
  _$$IGDBCoverImplCopyWith<_$IGDBCoverImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IGDBTheme _$IGDBThemeFromJson(Map<String, dynamic> json) {
  return _IGDBTheme.fromJson(json);
}

/// @nodoc
mixin _$IGDBTheme {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IGDBThemeCopyWith<IGDBTheme> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IGDBThemeCopyWith<$Res> {
  factory $IGDBThemeCopyWith(IGDBTheme value, $Res Function(IGDBTheme) then) =
      _$IGDBThemeCopyWithImpl<$Res, IGDBTheme>;
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class _$IGDBThemeCopyWithImpl<$Res, $Val extends IGDBTheme>
    implements $IGDBThemeCopyWith<$Res> {
  _$IGDBThemeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
abstract class _$$IGDBThemeImplCopyWith<$Res>
    implements $IGDBThemeCopyWith<$Res> {
  factory _$$IGDBThemeImplCopyWith(
          _$IGDBThemeImpl value, $Res Function(_$IGDBThemeImpl) then) =
      __$$IGDBThemeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class __$$IGDBThemeImplCopyWithImpl<$Res>
    extends _$IGDBThemeCopyWithImpl<$Res, _$IGDBThemeImpl>
    implements _$$IGDBThemeImplCopyWith<$Res> {
  __$$IGDBThemeImplCopyWithImpl(
      _$IGDBThemeImpl _value, $Res Function(_$IGDBThemeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_$IGDBThemeImpl(
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
class _$IGDBThemeImpl extends _IGDBTheme {
  const _$IGDBThemeImpl({this.id, this.name}) : super._();

  factory _$IGDBThemeImpl.fromJson(Map<String, dynamic> json) =>
      _$$IGDBThemeImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;

  @override
  String toString() {
    return 'IGDBTheme(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IGDBThemeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IGDBThemeImplCopyWith<_$IGDBThemeImpl> get copyWith =>
      __$$IGDBThemeImplCopyWithImpl<_$IGDBThemeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IGDBThemeImplToJson(
      this,
    );
  }
}

abstract class _IGDBTheme extends IGDBTheme {
  const factory _IGDBTheme({final int? id, final String? name}) =
      _$IGDBThemeImpl;
  const _IGDBTheme._() : super._();

  factory _IGDBTheme.fromJson(Map<String, dynamic> json) =
      _$IGDBThemeImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  @JsonKey(ignore: true)
  _$$IGDBThemeImplCopyWith<_$IGDBThemeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IGDBVideo _$IGDBVideoFromJson(Map<String, dynamic> json) {
  return _IGDBVideo.fromJson(json);
}

/// @nodoc
mixin _$IGDBVideo {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get video_id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IGDBVideoCopyWith<IGDBVideo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IGDBVideoCopyWith<$Res> {
  factory $IGDBVideoCopyWith(IGDBVideo value, $Res Function(IGDBVideo) then) =
      _$IGDBVideoCopyWithImpl<$Res, IGDBVideo>;
  @useResult
  $Res call({int? id, String? name, String? video_id});
}

/// @nodoc
class _$IGDBVideoCopyWithImpl<$Res, $Val extends IGDBVideo>
    implements $IGDBVideoCopyWith<$Res> {
  _$IGDBVideoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
abstract class _$$IGDBVideoImplCopyWith<$Res>
    implements $IGDBVideoCopyWith<$Res> {
  factory _$$IGDBVideoImplCopyWith(
          _$IGDBVideoImpl value, $Res Function(_$IGDBVideoImpl) then) =
      __$$IGDBVideoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? name, String? video_id});
}

/// @nodoc
class __$$IGDBVideoImplCopyWithImpl<$Res>
    extends _$IGDBVideoCopyWithImpl<$Res, _$IGDBVideoImpl>
    implements _$$IGDBVideoImplCopyWith<$Res> {
  __$$IGDBVideoImplCopyWithImpl(
      _$IGDBVideoImpl _value, $Res Function(_$IGDBVideoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? video_id = freezed,
  }) {
    return _then(_$IGDBVideoImpl(
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
class _$IGDBVideoImpl extends _IGDBVideo {
  const _$IGDBVideoImpl({this.id, this.name, this.video_id}) : super._();

  factory _$IGDBVideoImpl.fromJson(Map<String, dynamic> json) =>
      _$$IGDBVideoImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? video_id;

  @override
  String toString() {
    return 'IGDBVideo(id: $id, name: $name, video_id: $video_id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IGDBVideoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.video_id, video_id) ||
                other.video_id == video_id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, video_id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IGDBVideoImplCopyWith<_$IGDBVideoImpl> get copyWith =>
      __$$IGDBVideoImplCopyWithImpl<_$IGDBVideoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IGDBVideoImplToJson(
      this,
    );
  }
}

abstract class _IGDBVideo extends IGDBVideo {
  const factory _IGDBVideo(
      {final int? id,
      final String? name,
      final String? video_id}) = _$IGDBVideoImpl;
  const _IGDBVideo._() : super._();

  factory _IGDBVideo.fromJson(Map<String, dynamic> json) =
      _$IGDBVideoImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get video_id;
  @override
  @JsonKey(ignore: true)
  _$$IGDBVideoImplCopyWith<_$IGDBVideoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IGDBWebsite _$IGDBWebsiteFromJson(Map<String, dynamic> json) {
  return _IGDBWebsite.fromJson(json);
}

/// @nodoc
mixin _$IGDBWebsite {
  int? get id => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IGDBWebsiteCopyWith<IGDBWebsite> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IGDBWebsiteCopyWith<$Res> {
  factory $IGDBWebsiteCopyWith(
          IGDBWebsite value, $Res Function(IGDBWebsite) then) =
      _$IGDBWebsiteCopyWithImpl<$Res, IGDBWebsite>;
  @useResult
  $Res call({int? id, String? url});
}

/// @nodoc
class _$IGDBWebsiteCopyWithImpl<$Res, $Val extends IGDBWebsite>
    implements $IGDBWebsiteCopyWith<$Res> {
  _$IGDBWebsiteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
abstract class _$$IGDBWebsiteImplCopyWith<$Res>
    implements $IGDBWebsiteCopyWith<$Res> {
  factory _$$IGDBWebsiteImplCopyWith(
          _$IGDBWebsiteImpl value, $Res Function(_$IGDBWebsiteImpl) then) =
      __$$IGDBWebsiteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? url});
}

/// @nodoc
class __$$IGDBWebsiteImplCopyWithImpl<$Res>
    extends _$IGDBWebsiteCopyWithImpl<$Res, _$IGDBWebsiteImpl>
    implements _$$IGDBWebsiteImplCopyWith<$Res> {
  __$$IGDBWebsiteImplCopyWithImpl(
      _$IGDBWebsiteImpl _value, $Res Function(_$IGDBWebsiteImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? url = freezed,
  }) {
    return _then(_$IGDBWebsiteImpl(
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
class _$IGDBWebsiteImpl extends _IGDBWebsite {
  const _$IGDBWebsiteImpl({this.id, this.url}) : super._();

  factory _$IGDBWebsiteImpl.fromJson(Map<String, dynamic> json) =>
      _$$IGDBWebsiteImplFromJson(json);

  @override
  final int? id;
  @override
  final String? url;

  @override
  String toString() {
    return 'IGDBWebsite(id: $id, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IGDBWebsiteImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IGDBWebsiteImplCopyWith<_$IGDBWebsiteImpl> get copyWith =>
      __$$IGDBWebsiteImplCopyWithImpl<_$IGDBWebsiteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IGDBWebsiteImplToJson(
      this,
    );
  }
}

abstract class _IGDBWebsite extends IGDBWebsite {
  const factory _IGDBWebsite({final int? id, final String? url}) =
      _$IGDBWebsiteImpl;
  const _IGDBWebsite._() : super._();

  factory _IGDBWebsite.fromJson(Map<String, dynamic> json) =
      _$IGDBWebsiteImpl.fromJson;

  @override
  int? get id;
  @override
  String? get url;
  @override
  @JsonKey(ignore: true)
  _$$IGDBWebsiteImplCopyWith<_$IGDBWebsiteImpl> get copyWith =>
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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, token, expires_at);

  @JsonKey(ignore: true)
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
  @override
  @JsonKey(ignore: true)
  _$$IGDBAccessTokenImplCopyWith<_$IGDBAccessTokenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
