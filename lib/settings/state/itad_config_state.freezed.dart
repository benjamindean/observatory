// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'itad_config_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ITADConfigState _$ITADConfigStateFromJson(Map<String, dynamic> json) {
  return _ITADConfigState.fromJson(json);
}

/// @nodoc
mixin _$ITADConfigState {
  String get selectedCountry => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  List<int> get selectedStores => throw _privateConstructorUsedError;
  List<Store> get stores => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ITADConfigStateCopyWith<ITADConfigState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ITADConfigStateCopyWith<$Res> {
  factory $ITADConfigStateCopyWith(
          ITADConfigState value, $Res Function(ITADConfigState) then) =
      _$ITADConfigStateCopyWithImpl<$Res, ITADConfigState>;
  @useResult
  $Res call(
      {String selectedCountry,
      String currency,
      List<int> selectedStores,
      List<Store> stores});
}

/// @nodoc
class _$ITADConfigStateCopyWithImpl<$Res, $Val extends ITADConfigState>
    implements $ITADConfigStateCopyWith<$Res> {
  _$ITADConfigStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedCountry = null,
    Object? currency = null,
    Object? selectedStores = null,
    Object? stores = null,
  }) {
    return _then(_value.copyWith(
      selectedCountry: null == selectedCountry
          ? _value.selectedCountry
          : selectedCountry // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      selectedStores: null == selectedStores
          ? _value.selectedStores
          : selectedStores // ignore: cast_nullable_to_non_nullable
              as List<int>,
      stores: null == stores
          ? _value.stores
          : stores // ignore: cast_nullable_to_non_nullable
              as List<Store>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ITADConfigStateImplCopyWith<$Res>
    implements $ITADConfigStateCopyWith<$Res> {
  factory _$$ITADConfigStateImplCopyWith(_$ITADConfigStateImpl value,
          $Res Function(_$ITADConfigStateImpl) then) =
      __$$ITADConfigStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String selectedCountry,
      String currency,
      List<int> selectedStores,
      List<Store> stores});
}

/// @nodoc
class __$$ITADConfigStateImplCopyWithImpl<$Res>
    extends _$ITADConfigStateCopyWithImpl<$Res, _$ITADConfigStateImpl>
    implements _$$ITADConfigStateImplCopyWith<$Res> {
  __$$ITADConfigStateImplCopyWithImpl(
      _$ITADConfigStateImpl _value, $Res Function(_$ITADConfigStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedCountry = null,
    Object? currency = null,
    Object? selectedStores = null,
    Object? stores = null,
  }) {
    return _then(_$ITADConfigStateImpl(
      selectedCountry: null == selectedCountry
          ? _value.selectedCountry
          : selectedCountry // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      selectedStores: null == selectedStores
          ? _value._selectedStores
          : selectedStores // ignore: cast_nullable_to_non_nullable
              as List<int>,
      stores: null == stores
          ? _value._stores
          : stores // ignore: cast_nullable_to_non_nullable
              as List<Store>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ITADConfigStateImpl implements _ITADConfigState {
  _$ITADConfigStateImpl(
      {required this.selectedCountry,
      this.currency = 'USD',
      required final List<int> selectedStores,
      required final List<Store> stores})
      : _selectedStores = selectedStores,
        _stores = stores;

  factory _$ITADConfigStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$ITADConfigStateImplFromJson(json);

  @override
  final String selectedCountry;
  @override
  @JsonKey()
  final String currency;
  final List<int> _selectedStores;
  @override
  List<int> get selectedStores {
    if (_selectedStores is EqualUnmodifiableListView) return _selectedStores;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedStores);
  }

  final List<Store> _stores;
  @override
  List<Store> get stores {
    if (_stores is EqualUnmodifiableListView) return _stores;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stores);
  }

  @override
  String toString() {
    return 'ITADConfigState(selectedCountry: $selectedCountry, currency: $currency, selectedStores: $selectedStores, stores: $stores)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ITADConfigStateImpl &&
            (identical(other.selectedCountry, selectedCountry) ||
                other.selectedCountry == selectedCountry) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            const DeepCollectionEquality()
                .equals(other._selectedStores, _selectedStores) &&
            const DeepCollectionEquality().equals(other._stores, _stores));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      selectedCountry,
      currency,
      const DeepCollectionEquality().hash(_selectedStores),
      const DeepCollectionEquality().hash(_stores));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ITADConfigStateImplCopyWith<_$ITADConfigStateImpl> get copyWith =>
      __$$ITADConfigStateImplCopyWithImpl<_$ITADConfigStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ITADConfigStateImplToJson(
      this,
    );
  }
}

abstract class _ITADConfigState implements ITADConfigState {
  factory _ITADConfigState(
      {required final String selectedCountry,
      final String currency,
      required final List<int> selectedStores,
      required final List<Store> stores}) = _$ITADConfigStateImpl;

  factory _ITADConfigState.fromJson(Map<String, dynamic> json) =
      _$ITADConfigStateImpl.fromJson;

  @override
  String get selectedCountry;
  @override
  String get currency;
  @override
  List<int> get selectedStores;
  @override
  List<Store> get stores;
  @override
  @JsonKey(ignore: true)
  _$$ITADConfigStateImplCopyWith<_$ITADConfigStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
