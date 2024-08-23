// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'urls.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Urls _$UrlsFromJson(Map<String, dynamic> json) {
  return _Urls.fromJson(json);
}

/// @nodoc
mixin _$Urls {
  String? get package => throw _privateConstructorUsedError;
  String? get game => throw _privateConstructorUsedError;
  String? get dlc => throw _privateConstructorUsedError;
  String? get buy => throw _privateConstructorUsedError;

  /// Serializes this Urls to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Urls
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UrlsCopyWith<Urls> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UrlsCopyWith<$Res> {
  factory $UrlsCopyWith(Urls value, $Res Function(Urls) then) =
      _$UrlsCopyWithImpl<$Res, Urls>;
  @useResult
  $Res call({String? package, String? game, String? dlc, String? buy});
}

/// @nodoc
class _$UrlsCopyWithImpl<$Res, $Val extends Urls>
    implements $UrlsCopyWith<$Res> {
  _$UrlsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Urls
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? package = freezed,
    Object? game = freezed,
    Object? dlc = freezed,
    Object? buy = freezed,
  }) {
    return _then(_value.copyWith(
      package: freezed == package
          ? _value.package
          : package // ignore: cast_nullable_to_non_nullable
              as String?,
      game: freezed == game
          ? _value.game
          : game // ignore: cast_nullable_to_non_nullable
              as String?,
      dlc: freezed == dlc
          ? _value.dlc
          : dlc // ignore: cast_nullable_to_non_nullable
              as String?,
      buy: freezed == buy
          ? _value.buy
          : buy // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UrlsImplCopyWith<$Res> implements $UrlsCopyWith<$Res> {
  factory _$$UrlsImplCopyWith(
          _$UrlsImpl value, $Res Function(_$UrlsImpl) then) =
      __$$UrlsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? package, String? game, String? dlc, String? buy});
}

/// @nodoc
class __$$UrlsImplCopyWithImpl<$Res>
    extends _$UrlsCopyWithImpl<$Res, _$UrlsImpl>
    implements _$$UrlsImplCopyWith<$Res> {
  __$$UrlsImplCopyWithImpl(_$UrlsImpl _value, $Res Function(_$UrlsImpl) _then)
      : super(_value, _then);

  /// Create a copy of Urls
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? package = freezed,
    Object? game = freezed,
    Object? dlc = freezed,
    Object? buy = freezed,
  }) {
    return _then(_$UrlsImpl(
      package: freezed == package
          ? _value.package
          : package // ignore: cast_nullable_to_non_nullable
              as String?,
      game: freezed == game
          ? _value.game
          : game // ignore: cast_nullable_to_non_nullable
              as String?,
      dlc: freezed == dlc
          ? _value.dlc
          : dlc // ignore: cast_nullable_to_non_nullable
              as String?,
      buy: freezed == buy
          ? _value.buy
          : buy // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UrlsImpl with DiagnosticableTreeMixin implements _Urls {
  const _$UrlsImpl(
      {required this.package,
      required this.game,
      required this.dlc,
      required this.buy});

  factory _$UrlsImpl.fromJson(Map<String, dynamic> json) =>
      _$$UrlsImplFromJson(json);

  @override
  final String? package;
  @override
  final String? game;
  @override
  final String? dlc;
  @override
  final String? buy;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Urls(package: $package, game: $game, dlc: $dlc, buy: $buy)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Urls'))
      ..add(DiagnosticsProperty('package', package))
      ..add(DiagnosticsProperty('game', game))
      ..add(DiagnosticsProperty('dlc', dlc))
      ..add(DiagnosticsProperty('buy', buy));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UrlsImpl &&
            (identical(other.package, package) || other.package == package) &&
            (identical(other.game, game) || other.game == game) &&
            (identical(other.dlc, dlc) || other.dlc == dlc) &&
            (identical(other.buy, buy) || other.buy == buy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, package, game, dlc, buy);

  /// Create a copy of Urls
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UrlsImplCopyWith<_$UrlsImpl> get copyWith =>
      __$$UrlsImplCopyWithImpl<_$UrlsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UrlsImplToJson(
      this,
    );
  }
}

abstract class _Urls implements Urls {
  const factory _Urls(
      {required final String? package,
      required final String? game,
      required final String? dlc,
      required final String? buy}) = _$UrlsImpl;

  factory _Urls.fromJson(Map<String, dynamic> json) = _$UrlsImpl.fromJson;

  @override
  String? get package;
  @override
  String? get game;
  @override
  String? get dlc;
  @override
  String? get buy;

  /// Create a copy of Urls
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UrlsImplCopyWith<_$UrlsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
