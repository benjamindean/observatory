// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deals_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DealsState {
  List<Deal> get deals => throw _privateConstructorUsedError;
  bool get hasReachedMax => throw _privateConstructorUsedError;
  int get pageNumber => throw _privateConstructorUsedError;

  /// Create a copy of DealsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DealsStateCopyWith<DealsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DealsStateCopyWith<$Res> {
  factory $DealsStateCopyWith(
          DealsState value, $Res Function(DealsState) then) =
      _$DealsStateCopyWithImpl<$Res, DealsState>;
  @useResult
  $Res call({List<Deal> deals, bool hasReachedMax, int pageNumber});
}

/// @nodoc
class _$DealsStateCopyWithImpl<$Res, $Val extends DealsState>
    implements $DealsStateCopyWith<$Res> {
  _$DealsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DealsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deals = null,
    Object? hasReachedMax = null,
    Object? pageNumber = null,
  }) {
    return _then(_value.copyWith(
      deals: null == deals
          ? _value.deals
          : deals // ignore: cast_nullable_to_non_nullable
              as List<Deal>,
      hasReachedMax: null == hasReachedMax
          ? _value.hasReachedMax
          : hasReachedMax // ignore: cast_nullable_to_non_nullable
              as bool,
      pageNumber: null == pageNumber
          ? _value.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DealsStateImplCopyWith<$Res>
    implements $DealsStateCopyWith<$Res> {
  factory _$$DealsStateImplCopyWith(
          _$DealsStateImpl value, $Res Function(_$DealsStateImpl) then) =
      __$$DealsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Deal> deals, bool hasReachedMax, int pageNumber});
}

/// @nodoc
class __$$DealsStateImplCopyWithImpl<$Res>
    extends _$DealsStateCopyWithImpl<$Res, _$DealsStateImpl>
    implements _$$DealsStateImplCopyWith<$Res> {
  __$$DealsStateImplCopyWithImpl(
      _$DealsStateImpl _value, $Res Function(_$DealsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of DealsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deals = null,
    Object? hasReachedMax = null,
    Object? pageNumber = null,
  }) {
    return _then(_$DealsStateImpl(
      deals: null == deals
          ? _value._deals
          : deals // ignore: cast_nullable_to_non_nullable
              as List<Deal>,
      hasReachedMax: null == hasReachedMax
          ? _value.hasReachedMax
          : hasReachedMax // ignore: cast_nullable_to_non_nullable
              as bool,
      pageNumber: null == pageNumber
          ? _value.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$DealsStateImpl implements _DealsState {
  const _$DealsStateImpl(
      {required final List<Deal> deals,
      required this.hasReachedMax,
      required this.pageNumber})
      : _deals = deals;

  final List<Deal> _deals;
  @override
  List<Deal> get deals {
    if (_deals is EqualUnmodifiableListView) return _deals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deals);
  }

  @override
  final bool hasReachedMax;
  @override
  final int pageNumber;

  @override
  String toString() {
    return 'DealsState(deals: $deals, hasReachedMax: $hasReachedMax, pageNumber: $pageNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DealsStateImpl &&
            const DeepCollectionEquality().equals(other._deals, _deals) &&
            (identical(other.hasReachedMax, hasReachedMax) ||
                other.hasReachedMax == hasReachedMax) &&
            (identical(other.pageNumber, pageNumber) ||
                other.pageNumber == pageNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_deals), hasReachedMax, pageNumber);

  /// Create a copy of DealsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DealsStateImplCopyWith<_$DealsStateImpl> get copyWith =>
      __$$DealsStateImplCopyWithImpl<_$DealsStateImpl>(this, _$identity);
}

abstract class _DealsState implements DealsState {
  const factory _DealsState(
      {required final List<Deal> deals,
      required final bool hasReachedMax,
      required final int pageNumber}) = _$DealsStateImpl;

  @override
  List<Deal> get deals;
  @override
  bool get hasReachedMax;
  @override
  int get pageNumber;

  /// Create a copy of DealsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DealsStateImplCopyWith<_$DealsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
