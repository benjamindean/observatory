// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HistoryPrice _$HistoryPriceFromJson(Map<String, dynamic> json) {
  return _HistoryPrice.fromJson(json);
}

/// @nodoc
mixin _$HistoryPrice {
  PriceDetails get price => throw _privateConstructorUsedError;
  PriceDetails get regular => throw _privateConstructorUsedError;
  double get cut => throw _privateConstructorUsedError;

  /// Serializes this HistoryPrice to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HistoryPrice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HistoryPriceCopyWith<HistoryPrice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryPriceCopyWith<$Res> {
  factory $HistoryPriceCopyWith(
          HistoryPrice value, $Res Function(HistoryPrice) then) =
      _$HistoryPriceCopyWithImpl<$Res, HistoryPrice>;
  @useResult
  $Res call({PriceDetails price, PriceDetails regular, double cut});

  $PriceDetailsCopyWith<$Res> get price;
  $PriceDetailsCopyWith<$Res> get regular;
}

/// @nodoc
class _$HistoryPriceCopyWithImpl<$Res, $Val extends HistoryPrice>
    implements $HistoryPriceCopyWith<$Res> {
  _$HistoryPriceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HistoryPrice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? price = null,
    Object? regular = null,
    Object? cut = null,
  }) {
    return _then(_value.copyWith(
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as PriceDetails,
      regular: null == regular
          ? _value.regular
          : regular // ignore: cast_nullable_to_non_nullable
              as PriceDetails,
      cut: null == cut
          ? _value.cut
          : cut // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }

  /// Create a copy of HistoryPrice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PriceDetailsCopyWith<$Res> get price {
    return $PriceDetailsCopyWith<$Res>(_value.price, (value) {
      return _then(_value.copyWith(price: value) as $Val);
    });
  }

  /// Create a copy of HistoryPrice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PriceDetailsCopyWith<$Res> get regular {
    return $PriceDetailsCopyWith<$Res>(_value.regular, (value) {
      return _then(_value.copyWith(regular: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HistoryPriceImplCopyWith<$Res>
    implements $HistoryPriceCopyWith<$Res> {
  factory _$$HistoryPriceImplCopyWith(
          _$HistoryPriceImpl value, $Res Function(_$HistoryPriceImpl) then) =
      __$$HistoryPriceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PriceDetails price, PriceDetails regular, double cut});

  @override
  $PriceDetailsCopyWith<$Res> get price;
  @override
  $PriceDetailsCopyWith<$Res> get regular;
}

/// @nodoc
class __$$HistoryPriceImplCopyWithImpl<$Res>
    extends _$HistoryPriceCopyWithImpl<$Res, _$HistoryPriceImpl>
    implements _$$HistoryPriceImplCopyWith<$Res> {
  __$$HistoryPriceImplCopyWithImpl(
      _$HistoryPriceImpl _value, $Res Function(_$HistoryPriceImpl) _then)
      : super(_value, _then);

  /// Create a copy of HistoryPrice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? price = null,
    Object? regular = null,
    Object? cut = null,
  }) {
    return _then(_$HistoryPriceImpl(
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as PriceDetails,
      regular: null == regular
          ? _value.regular
          : regular // ignore: cast_nullable_to_non_nullable
              as PriceDetails,
      cut: null == cut
          ? _value.cut
          : cut // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HistoryPriceImpl with DiagnosticableTreeMixin implements _HistoryPrice {
  const _$HistoryPriceImpl(
      {required this.price, required this.regular, this.cut = 0});

  factory _$HistoryPriceImpl.fromJson(Map<String, dynamic> json) =>
      _$$HistoryPriceImplFromJson(json);

  @override
  final PriceDetails price;
  @override
  final PriceDetails regular;
  @override
  @JsonKey()
  final double cut;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HistoryPrice(price: $price, regular: $regular, cut: $cut)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'HistoryPrice'))
      ..add(DiagnosticsProperty('price', price))
      ..add(DiagnosticsProperty('regular', regular))
      ..add(DiagnosticsProperty('cut', cut));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryPriceImpl &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.regular, regular) || other.regular == regular) &&
            (identical(other.cut, cut) || other.cut == cut));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, price, regular, cut);

  /// Create a copy of HistoryPrice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryPriceImplCopyWith<_$HistoryPriceImpl> get copyWith =>
      __$$HistoryPriceImplCopyWithImpl<_$HistoryPriceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HistoryPriceImplToJson(
      this,
    );
  }
}

abstract class _HistoryPrice implements HistoryPrice {
  const factory _HistoryPrice(
      {required final PriceDetails price,
      required final PriceDetails regular,
      final double cut}) = _$HistoryPriceImpl;

  factory _HistoryPrice.fromJson(Map<String, dynamic> json) =
      _$HistoryPriceImpl.fromJson;

  @override
  PriceDetails get price;
  @override
  PriceDetails get regular;
  @override
  double get cut;

  /// Create a copy of HistoryPrice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HistoryPriceImplCopyWith<_$HistoryPriceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

History _$HistoryFromJson(Map<String, dynamic> json) {
  return _History.fromJson(json);
}

/// @nodoc
mixin _$History {
  int get timestamp => throw _privateConstructorUsedError;
  Shop? get shop => throw _privateConstructorUsedError;
  HistoryPrice? get deal => throw _privateConstructorUsedError;

  /// Serializes this History to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of History
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HistoryCopyWith<History> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryCopyWith<$Res> {
  factory $HistoryCopyWith(History value, $Res Function(History) then) =
      _$HistoryCopyWithImpl<$Res, History>;
  @useResult
  $Res call({int timestamp, Shop? shop, HistoryPrice? deal});

  $ShopCopyWith<$Res>? get shop;
  $HistoryPriceCopyWith<$Res>? get deal;
}

/// @nodoc
class _$HistoryCopyWithImpl<$Res, $Val extends History>
    implements $HistoryCopyWith<$Res> {
  _$HistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of History
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? shop = freezed,
    Object? deal = freezed,
  }) {
    return _then(_value.copyWith(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      shop: freezed == shop
          ? _value.shop
          : shop // ignore: cast_nullable_to_non_nullable
              as Shop?,
      deal: freezed == deal
          ? _value.deal
          : deal // ignore: cast_nullable_to_non_nullable
              as HistoryPrice?,
    ) as $Val);
  }

  /// Create a copy of History
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ShopCopyWith<$Res>? get shop {
    if (_value.shop == null) {
      return null;
    }

    return $ShopCopyWith<$Res>(_value.shop!, (value) {
      return _then(_value.copyWith(shop: value) as $Val);
    });
  }

  /// Create a copy of History
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HistoryPriceCopyWith<$Res>? get deal {
    if (_value.deal == null) {
      return null;
    }

    return $HistoryPriceCopyWith<$Res>(_value.deal!, (value) {
      return _then(_value.copyWith(deal: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HistoryImplCopyWith<$Res> implements $HistoryCopyWith<$Res> {
  factory _$$HistoryImplCopyWith(
          _$HistoryImpl value, $Res Function(_$HistoryImpl) then) =
      __$$HistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int timestamp, Shop? shop, HistoryPrice? deal});

  @override
  $ShopCopyWith<$Res>? get shop;
  @override
  $HistoryPriceCopyWith<$Res>? get deal;
}

/// @nodoc
class __$$HistoryImplCopyWithImpl<$Res>
    extends _$HistoryCopyWithImpl<$Res, _$HistoryImpl>
    implements _$$HistoryImplCopyWith<$Res> {
  __$$HistoryImplCopyWithImpl(
      _$HistoryImpl _value, $Res Function(_$HistoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of History
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? shop = freezed,
    Object? deal = freezed,
  }) {
    return _then(_$HistoryImpl(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      shop: freezed == shop
          ? _value.shop
          : shop // ignore: cast_nullable_to_non_nullable
              as Shop?,
      deal: freezed == deal
          ? _value.deal
          : deal // ignore: cast_nullable_to_non_nullable
              as HistoryPrice?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HistoryImpl with DiagnosticableTreeMixin implements _History {
  const _$HistoryImpl({required this.timestamp, this.shop, this.deal});

  factory _$HistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$HistoryImplFromJson(json);

  @override
  final int timestamp;
  @override
  final Shop? shop;
  @override
  final HistoryPrice? deal;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'History(timestamp: $timestamp, shop: $shop, deal: $deal)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'History'))
      ..add(DiagnosticsProperty('timestamp', timestamp))
      ..add(DiagnosticsProperty('shop', shop))
      ..add(DiagnosticsProperty('deal', deal));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryImpl &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.shop, shop) || other.shop == shop) &&
            (identical(other.deal, deal) || other.deal == deal));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, timestamp, shop, deal);

  /// Create a copy of History
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryImplCopyWith<_$HistoryImpl> get copyWith =>
      __$$HistoryImplCopyWithImpl<_$HistoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HistoryImplToJson(
      this,
    );
  }
}

abstract class _History implements History {
  const factory _History(
      {required final int timestamp,
      final Shop? shop,
      final HistoryPrice? deal}) = _$HistoryImpl;

  factory _History.fromJson(Map<String, dynamic> json) = _$HistoryImpl.fromJson;

  @override
  int get timestamp;
  @override
  Shop? get shop;
  @override
  HistoryPrice? get deal;

  /// Create a copy of History
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HistoryImplCopyWith<_$HistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
