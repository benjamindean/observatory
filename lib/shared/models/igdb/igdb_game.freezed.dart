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
  String? get slug => throw _privateConstructorUsedError;
  String? get summary => throw _privateConstructorUsedError;
  String? get storyline => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  IGDBCover? get cover => throw _privateConstructorUsedError;
  List<IGDBScreenshot> get screenshots => throw _privateConstructorUsedError;
  List<IGDBPlatform> get platforms => throw _privateConstructorUsedError;

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
      String? slug,
      String? summary,
      String? storyline,
      String? url,
      IGDBCover? cover,
      List<IGDBScreenshot> screenshots,
      List<IGDBPlatform> platforms});

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
    Object? slug = freezed,
    Object? summary = freezed,
    Object? storyline = freezed,
    Object? url = freezed,
    Object? cover = freezed,
    Object? screenshots = null,
    Object? platforms = null,
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
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
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
      cover: freezed == cover
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as IGDBCover?,
      screenshots: null == screenshots
          ? _value.screenshots
          : screenshots // ignore: cast_nullable_to_non_nullable
              as List<IGDBScreenshot>,
      platforms: null == platforms
          ? _value.platforms
          : platforms // ignore: cast_nullable_to_non_nullable
              as List<IGDBPlatform>,
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
      String? slug,
      String? summary,
      String? storyline,
      String? url,
      IGDBCover? cover,
      List<IGDBScreenshot> screenshots,
      List<IGDBPlatform> platforms});

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
    Object? slug = freezed,
    Object? summary = freezed,
    Object? storyline = freezed,
    Object? url = freezed,
    Object? cover = freezed,
    Object? screenshots = null,
    Object? platforms = null,
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
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
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
      cover: freezed == cover
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as IGDBCover?,
      screenshots: null == screenshots
          ? _value._screenshots
          : screenshots // ignore: cast_nullable_to_non_nullable
              as List<IGDBScreenshot>,
      platforms: null == platforms
          ? _value._platforms
          : platforms // ignore: cast_nullable_to_non_nullable
              as List<IGDBPlatform>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IGDBGameImpl extends _IGDBGame {
  const _$IGDBGameImpl(
      {this.id,
      this.name,
      this.slug,
      this.summary,
      this.storyline,
      this.url,
      this.cover,
      final List<IGDBScreenshot> screenshots = const [],
      final List<IGDBPlatform> platforms = const []})
      : _screenshots = screenshots,
        _platforms = platforms,
        super._();

  factory _$IGDBGameImpl.fromJson(Map<String, dynamic> json) =>
      _$$IGDBGameImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? slug;
  @override
  final String? summary;
  @override
  final String? storyline;
  @override
  final String? url;
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

  final List<IGDBPlatform> _platforms;
  @override
  @JsonKey()
  List<IGDBPlatform> get platforms {
    if (_platforms is EqualUnmodifiableListView) return _platforms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_platforms);
  }

  @override
  String toString() {
    return 'IGDBGame(id: $id, name: $name, slug: $slug, summary: $summary, storyline: $storyline, url: $url, cover: $cover, screenshots: $screenshots, platforms: $platforms)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IGDBGameImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.storyline, storyline) ||
                other.storyline == storyline) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.cover, cover) || other.cover == cover) &&
            const DeepCollectionEquality()
                .equals(other._screenshots, _screenshots) &&
            const DeepCollectionEquality()
                .equals(other._platforms, _platforms));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      slug,
      summary,
      storyline,
      url,
      cover,
      const DeepCollectionEquality().hash(_screenshots),
      const DeepCollectionEquality().hash(_platforms));

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
      final String? slug,
      final String? summary,
      final String? storyline,
      final String? url,
      final IGDBCover? cover,
      final List<IGDBScreenshot> screenshots,
      final List<IGDBPlatform> platforms}) = _$IGDBGameImpl;
  const _IGDBGame._() : super._();

  factory _IGDBGame.fromJson(Map<String, dynamic> json) =
      _$IGDBGameImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get slug;
  @override
  String? get summary;
  @override
  String? get storyline;
  @override
  String? get url;
  @override
  IGDBCover? get cover;
  @override
  List<IGDBScreenshot> get screenshots;
  @override
  List<IGDBPlatform> get platforms;
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
  $Res call({int? id, String? name});
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
abstract class _$$IGDBPlatformImplCopyWith<$Res>
    implements $IGDBPlatformCopyWith<$Res> {
  factory _$$IGDBPlatformImplCopyWith(
          _$IGDBPlatformImpl value, $Res Function(_$IGDBPlatformImpl) then) =
      __$$IGDBPlatformImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? name});
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IGDBPlatformImpl extends _IGDBPlatform {
  const _$IGDBPlatformImpl({this.id, this.name}) : super._();

  factory _$IGDBPlatformImpl.fromJson(Map<String, dynamic> json) =>
      _$$IGDBPlatformImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;

  @override
  String toString() {
    return 'IGDBPlatform(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IGDBPlatformImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

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
  const factory _IGDBPlatform({final int? id, final String? name}) =
      _$IGDBPlatformImpl;
  const _IGDBPlatform._() : super._();

  factory _IGDBPlatform.fromJson(Map<String, dynamic> json) =
      _$IGDBPlatformImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
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
