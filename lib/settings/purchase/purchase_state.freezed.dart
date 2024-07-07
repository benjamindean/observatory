// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchase_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PurchaseState {
  List<ProductDetails> get products => throw _privateConstructorUsedError;
  PurchaseStatus? get status => throw _privateConstructorUsedError;
  bool get isPending => throw _privateConstructorUsedError;
  List<String> get purchasedProductIds => throw _privateConstructorUsedError;
  StreamSubscription<List<PurchaseDetails>>? get subscription =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PurchaseStateCopyWith<PurchaseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseStateCopyWith<$Res> {
  factory $PurchaseStateCopyWith(
          PurchaseState value, $Res Function(PurchaseState) then) =
      _$PurchaseStateCopyWithImpl<$Res, PurchaseState>;
  @useResult
  $Res call(
      {List<ProductDetails> products,
      PurchaseStatus? status,
      bool isPending,
      List<String> purchasedProductIds,
      StreamSubscription<List<PurchaseDetails>>? subscription});
}

/// @nodoc
class _$PurchaseStateCopyWithImpl<$Res, $Val extends PurchaseState>
    implements $PurchaseStateCopyWith<$Res> {
  _$PurchaseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? products = null,
    Object? status = freezed,
    Object? isPending = null,
    Object? purchasedProductIds = null,
    Object? subscription = freezed,
  }) {
    return _then(_value.copyWith(
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductDetails>,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PurchaseStatus?,
      isPending: null == isPending
          ? _value.isPending
          : isPending // ignore: cast_nullable_to_non_nullable
              as bool,
      purchasedProductIds: null == purchasedProductIds
          ? _value.purchasedProductIds
          : purchasedProductIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      subscription: freezed == subscription
          ? _value.subscription
          : subscription // ignore: cast_nullable_to_non_nullable
              as StreamSubscription<List<PurchaseDetails>>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PurchaseStateImplCopyWith<$Res>
    implements $PurchaseStateCopyWith<$Res> {
  factory _$$PurchaseStateImplCopyWith(
          _$PurchaseStateImpl value, $Res Function(_$PurchaseStateImpl) then) =
      __$$PurchaseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ProductDetails> products,
      PurchaseStatus? status,
      bool isPending,
      List<String> purchasedProductIds,
      StreamSubscription<List<PurchaseDetails>>? subscription});
}

/// @nodoc
class __$$PurchaseStateImplCopyWithImpl<$Res>
    extends _$PurchaseStateCopyWithImpl<$Res, _$PurchaseStateImpl>
    implements _$$PurchaseStateImplCopyWith<$Res> {
  __$$PurchaseStateImplCopyWithImpl(
      _$PurchaseStateImpl _value, $Res Function(_$PurchaseStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? products = null,
    Object? status = freezed,
    Object? isPending = null,
    Object? purchasedProductIds = null,
    Object? subscription = freezed,
  }) {
    return _then(_$PurchaseStateImpl(
      products: null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductDetails>,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PurchaseStatus?,
      isPending: null == isPending
          ? _value.isPending
          : isPending // ignore: cast_nullable_to_non_nullable
              as bool,
      purchasedProductIds: null == purchasedProductIds
          ? _value._purchasedProductIds
          : purchasedProductIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      subscription: freezed == subscription
          ? _value.subscription
          : subscription // ignore: cast_nullable_to_non_nullable
              as StreamSubscription<List<PurchaseDetails>>?,
    ));
  }
}

/// @nodoc

class _$PurchaseStateImpl implements _PurchaseState {
  _$PurchaseStateImpl(
      {final List<ProductDetails> products = const [],
      this.status,
      this.isPending = false,
      final List<String> purchasedProductIds = const [],
      this.subscription})
      : _products = products,
        _purchasedProductIds = purchasedProductIds;

  final List<ProductDetails> _products;
  @override
  @JsonKey()
  List<ProductDetails> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  final PurchaseStatus? status;
  @override
  @JsonKey()
  final bool isPending;
  final List<String> _purchasedProductIds;
  @override
  @JsonKey()
  List<String> get purchasedProductIds {
    if (_purchasedProductIds is EqualUnmodifiableListView)
      return _purchasedProductIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_purchasedProductIds);
  }

  @override
  final StreamSubscription<List<PurchaseDetails>>? subscription;

  @override
  String toString() {
    return 'PurchaseState(products: $products, status: $status, isPending: $isPending, purchasedProductIds: $purchasedProductIds, subscription: $subscription)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchaseStateImpl &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isPending, isPending) ||
                other.isPending == isPending) &&
            const DeepCollectionEquality()
                .equals(other._purchasedProductIds, _purchasedProductIds) &&
            (identical(other.subscription, subscription) ||
                other.subscription == subscription));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_products),
      status,
      isPending,
      const DeepCollectionEquality().hash(_purchasedProductIds),
      subscription);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchaseStateImplCopyWith<_$PurchaseStateImpl> get copyWith =>
      __$$PurchaseStateImplCopyWithImpl<_$PurchaseStateImpl>(this, _$identity);
}

abstract class _PurchaseState implements PurchaseState {
  factory _PurchaseState(
          {final List<ProductDetails> products,
          final PurchaseStatus? status,
          final bool isPending,
          final List<String> purchasedProductIds,
          final StreamSubscription<List<PurchaseDetails>>? subscription}) =
      _$PurchaseStateImpl;

  @override
  List<ProductDetails> get products;
  @override
  PurchaseStatus? get status;
  @override
  bool get isPending;
  @override
  List<String> get purchasedProductIds;
  @override
  StreamSubscription<List<PurchaseDetails>>? get subscription;
  @override
  @JsonKey(ignore: true)
  _$$PurchaseStateImplCopyWith<_$PurchaseStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
