// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'combined_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CombinedDetails {
  IGDBGame? get igdb => throw _privateConstructorUsedError;
  Info? get itad => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CombinedDetailsCopyWith<CombinedDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CombinedDetailsCopyWith<$Res> {
  factory $CombinedDetailsCopyWith(
          CombinedDetails value, $Res Function(CombinedDetails) then) =
      _$CombinedDetailsCopyWithImpl<$Res, CombinedDetails>;
  @useResult
  $Res call({IGDBGame? igdb, Info? itad});

  $IGDBGameCopyWith<$Res>? get igdb;
  $InfoCopyWith<$Res>? get itad;
}

/// @nodoc
class _$CombinedDetailsCopyWithImpl<$Res, $Val extends CombinedDetails>
    implements $CombinedDetailsCopyWith<$Res> {
  _$CombinedDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? igdb = freezed,
    Object? itad = freezed,
  }) {
    return _then(_value.copyWith(
      igdb: freezed == igdb
          ? _value.igdb
          : igdb // ignore: cast_nullable_to_non_nullable
              as IGDBGame?,
      itad: freezed == itad
          ? _value.itad
          : itad // ignore: cast_nullable_to_non_nullable
              as Info?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $IGDBGameCopyWith<$Res>? get igdb {
    if (_value.igdb == null) {
      return null;
    }

    return $IGDBGameCopyWith<$Res>(_value.igdb!, (value) {
      return _then(_value.copyWith(igdb: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $InfoCopyWith<$Res>? get itad {
    if (_value.itad == null) {
      return null;
    }

    return $InfoCopyWith<$Res>(_value.itad!, (value) {
      return _then(_value.copyWith(itad: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CombinedDetailsImplCopyWith<$Res>
    implements $CombinedDetailsCopyWith<$Res> {
  factory _$$CombinedDetailsImplCopyWith(_$CombinedDetailsImpl value,
          $Res Function(_$CombinedDetailsImpl) then) =
      __$$CombinedDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({IGDBGame? igdb, Info? itad});

  @override
  $IGDBGameCopyWith<$Res>? get igdb;
  @override
  $InfoCopyWith<$Res>? get itad;
}

/// @nodoc
class __$$CombinedDetailsImplCopyWithImpl<$Res>
    extends _$CombinedDetailsCopyWithImpl<$Res, _$CombinedDetailsImpl>
    implements _$$CombinedDetailsImplCopyWith<$Res> {
  __$$CombinedDetailsImplCopyWithImpl(
      _$CombinedDetailsImpl _value, $Res Function(_$CombinedDetailsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? igdb = freezed,
    Object? itad = freezed,
  }) {
    return _then(_$CombinedDetailsImpl(
      igdb: freezed == igdb
          ? _value.igdb
          : igdb // ignore: cast_nullable_to_non_nullable
              as IGDBGame?,
      itad: freezed == itad
          ? _value.itad
          : itad // ignore: cast_nullable_to_non_nullable
              as Info?,
    ));
  }
}

/// @nodoc

class _$CombinedDetailsImpl
    with DiagnosticableTreeMixin
    implements _CombinedDetails {
  const _$CombinedDetailsImpl({this.igdb, this.itad});

  @override
  final IGDBGame? igdb;
  @override
  final Info? itad;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CombinedDetails(igdb: $igdb, itad: $itad)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CombinedDetails'))
      ..add(DiagnosticsProperty('igdb', igdb))
      ..add(DiagnosticsProperty('itad', itad));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CombinedDetailsImpl &&
            (identical(other.igdb, igdb) || other.igdb == igdb) &&
            (identical(other.itad, itad) || other.itad == itad));
  }

  @override
  int get hashCode => Object.hash(runtimeType, igdb, itad);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CombinedDetailsImplCopyWith<_$CombinedDetailsImpl> get copyWith =>
      __$$CombinedDetailsImplCopyWithImpl<_$CombinedDetailsImpl>(
          this, _$identity);
}

abstract class _CombinedDetails implements CombinedDetails {
  const factory _CombinedDetails({final IGDBGame? igdb, final Info? itad}) =
      _$CombinedDetailsImpl;

  @override
  IGDBGame? get igdb;
  @override
  Info? get itad;
  @override
  @JsonKey(ignore: true)
  _$$CombinedDetailsImplCopyWith<_$CombinedDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
