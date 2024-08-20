// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'observatory_theme.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ObservatoryTheme _$ObservatoryThemeFromJson(Map<String, dynamic> json) {
  return _ObservatoryTheme.fromJson(json);
}

/// @nodoc
mixin _$ObservatoryTheme {
  @HiveField(0)
  String get mode => throw _privateConstructorUsedError;
  @HiveField(1)
  bool get isTrueBlack => throw _privateConstructorUsedError;
  @HiveField(2)
  String? get scheme => throw _privateConstructorUsedError;

  /// Serializes this ObservatoryTheme to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ObservatoryTheme
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ObservatoryThemeCopyWith<ObservatoryTheme> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ObservatoryThemeCopyWith<$Res> {
  factory $ObservatoryThemeCopyWith(
          ObservatoryTheme value, $Res Function(ObservatoryTheme) then) =
      _$ObservatoryThemeCopyWithImpl<$Res, ObservatoryTheme>;
  @useResult
  $Res call(
      {@HiveField(0) String mode,
      @HiveField(1) bool isTrueBlack,
      @HiveField(2) String? scheme});
}

/// @nodoc
class _$ObservatoryThemeCopyWithImpl<$Res, $Val extends ObservatoryTheme>
    implements $ObservatoryThemeCopyWith<$Res> {
  _$ObservatoryThemeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ObservatoryTheme
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? isTrueBlack = null,
    Object? scheme = freezed,
  }) {
    return _then(_value.copyWith(
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as String,
      isTrueBlack: null == isTrueBlack
          ? _value.isTrueBlack
          : isTrueBlack // ignore: cast_nullable_to_non_nullable
              as bool,
      scheme: freezed == scheme
          ? _value.scheme
          : scheme // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ObservatoryThemeImplCopyWith<$Res>
    implements $ObservatoryThemeCopyWith<$Res> {
  factory _$$ObservatoryThemeImplCopyWith(_$ObservatoryThemeImpl value,
          $Res Function(_$ObservatoryThemeImpl) then) =
      __$$ObservatoryThemeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String mode,
      @HiveField(1) bool isTrueBlack,
      @HiveField(2) String? scheme});
}

/// @nodoc
class __$$ObservatoryThemeImplCopyWithImpl<$Res>
    extends _$ObservatoryThemeCopyWithImpl<$Res, _$ObservatoryThemeImpl>
    implements _$$ObservatoryThemeImplCopyWith<$Res> {
  __$$ObservatoryThemeImplCopyWithImpl(_$ObservatoryThemeImpl _value,
      $Res Function(_$ObservatoryThemeImpl) _then)
      : super(_value, _then);

  /// Create a copy of ObservatoryTheme
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? isTrueBlack = null,
    Object? scheme = freezed,
  }) {
    return _then(_$ObservatoryThemeImpl(
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as String,
      isTrueBlack: null == isTrueBlack
          ? _value.isTrueBlack
          : isTrueBlack // ignore: cast_nullable_to_non_nullable
              as bool,
      scheme: freezed == scheme
          ? _value.scheme
          : scheme // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ObservatoryThemeImpl extends _ObservatoryTheme {
  const _$ObservatoryThemeImpl(
      {@HiveField(0) required this.mode,
      @HiveField(1) required this.isTrueBlack,
      @HiveField(2) this.scheme = 'mandyRed'})
      : super._();

  factory _$ObservatoryThemeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ObservatoryThemeImplFromJson(json);

  @override
  @HiveField(0)
  final String mode;
  @override
  @HiveField(1)
  final bool isTrueBlack;
  @override
  @JsonKey()
  @HiveField(2)
  final String? scheme;

  @override
  String toString() {
    return 'ObservatoryTheme(mode: $mode, isTrueBlack: $isTrueBlack, scheme: $scheme)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ObservatoryThemeImpl &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.isTrueBlack, isTrueBlack) ||
                other.isTrueBlack == isTrueBlack) &&
            (identical(other.scheme, scheme) || other.scheme == scheme));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, mode, isTrueBlack, scheme);

  /// Create a copy of ObservatoryTheme
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ObservatoryThemeImplCopyWith<_$ObservatoryThemeImpl> get copyWith =>
      __$$ObservatoryThemeImplCopyWithImpl<_$ObservatoryThemeImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ObservatoryThemeImplToJson(
      this,
    );
  }
}

abstract class _ObservatoryTheme extends ObservatoryTheme {
  const factory _ObservatoryTheme(
      {@HiveField(0) required final String mode,
      @HiveField(1) required final bool isTrueBlack,
      @HiveField(2) final String? scheme}) = _$ObservatoryThemeImpl;
  const _ObservatoryTheme._() : super._();

  factory _ObservatoryTheme.fromJson(Map<String, dynamic> json) =
      _$ObservatoryThemeImpl.fromJson;

  @override
  @HiveField(0)
  String get mode;
  @override
  @HiveField(1)
  bool get isTrueBlack;
  @override
  @HiveField(2)
  String? get scheme;

  /// Create a copy of ObservatoryTheme
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ObservatoryThemeImplCopyWith<_$ObservatoryThemeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
