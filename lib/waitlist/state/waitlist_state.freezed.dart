// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'waitlist_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WaitListState {
  List<String> get ids => throw _privateConstructorUsedError;
  List<Deal> get deals => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WaitListStateCopyWith<WaitListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WaitListStateCopyWith<$Res> {
  factory $WaitListStateCopyWith(
          WaitListState value, $Res Function(WaitListState) then) =
      _$WaitListStateCopyWithImpl<$Res, WaitListState>;
  @useResult
  $Res call({List<String> ids, List<Deal> deals});
}

/// @nodoc
class _$WaitListStateCopyWithImpl<$Res, $Val extends WaitListState>
    implements $WaitListStateCopyWith<$Res> {
  _$WaitListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ids = null,
    Object? deals = null,
  }) {
    return _then(_value.copyWith(
      ids: null == ids
          ? _value.ids
          : ids // ignore: cast_nullable_to_non_nullable
              as List<String>,
      deals: null == deals
          ? _value.deals
          : deals // ignore: cast_nullable_to_non_nullable
              as List<Deal>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WaitListStateImplCopyWith<$Res>
    implements $WaitListStateCopyWith<$Res> {
  factory _$$WaitListStateImplCopyWith(
          _$WaitListStateImpl value, $Res Function(_$WaitListStateImpl) then) =
      __$$WaitListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> ids, List<Deal> deals});
}

/// @nodoc
class __$$WaitListStateImplCopyWithImpl<$Res>
    extends _$WaitListStateCopyWithImpl<$Res, _$WaitListStateImpl>
    implements _$$WaitListStateImplCopyWith<$Res> {
  __$$WaitListStateImplCopyWithImpl(
      _$WaitListStateImpl _value, $Res Function(_$WaitListStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ids = null,
    Object? deals = null,
  }) {
    return _then(_$WaitListStateImpl(
      ids: null == ids
          ? _value._ids
          : ids // ignore: cast_nullable_to_non_nullable
              as List<String>,
      deals: null == deals
          ? _value._deals
          : deals // ignore: cast_nullable_to_non_nullable
              as List<Deal>,
    ));
  }
}

/// @nodoc

class _$WaitListStateImpl extends _WaitListState {
  const _$WaitListStateImpl(
      {required final List<String> ids, required final List<Deal> deals})
      : _ids = ids,
        _deals = deals,
        super._();

  final List<String> _ids;
  @override
  List<String> get ids {
    if (_ids is EqualUnmodifiableListView) return _ids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ids);
  }

  final List<Deal> _deals;
  @override
  List<Deal> get deals {
    if (_deals is EqualUnmodifiableListView) return _deals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deals);
  }

  @override
  String toString() {
    return 'WaitListState(ids: $ids, deals: $deals)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WaitListStateImpl &&
            const DeepCollectionEquality().equals(other._ids, _ids) &&
            const DeepCollectionEquality().equals(other._deals, _deals));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_ids),
      const DeepCollectionEquality().hash(_deals));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WaitListStateImplCopyWith<_$WaitListStateImpl> get copyWith =>
      __$$WaitListStateImplCopyWithImpl<_$WaitListStateImpl>(this, _$identity);
}

abstract class _WaitListState extends WaitListState {
  const factory _WaitListState(
      {required final List<String> ids,
      required final List<Deal> deals}) = _$WaitListStateImpl;
  const _WaitListState._() : super._();

  @override
  List<String> get ids;
  @override
  List<Deal> get deals;
  @override
  @JsonKey(ignore: true)
  _$$WaitListStateImplCopyWith<_$WaitListStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
