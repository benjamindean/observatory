// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'price.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DRM _$DRMFromJson(Map<String, dynamic> json) {
  return _DRM.fromJson(json);
}

/// @nodoc
mixin _$DRM {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this DRM to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DRM
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DRMCopyWith<DRM> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DRMCopyWith<$Res> {
  factory $DRMCopyWith(DRM value, $Res Function(DRM) then) =
      _$DRMCopyWithImpl<$Res, DRM>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$DRMCopyWithImpl<$Res, $Val extends DRM> implements $DRMCopyWith<$Res> {
  _$DRMCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DRM
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DRMImplCopyWith<$Res> implements $DRMCopyWith<$Res> {
  factory _$$DRMImplCopyWith(_$DRMImpl value, $Res Function(_$DRMImpl) then) =
      __$$DRMImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$DRMImplCopyWithImpl<$Res> extends _$DRMCopyWithImpl<$Res, _$DRMImpl>
    implements _$$DRMImplCopyWith<$Res> {
  __$$DRMImplCopyWithImpl(_$DRMImpl _value, $Res Function(_$DRMImpl) _then)
      : super(_value, _then);

  /// Create a copy of DRM
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$DRMImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DRMImpl implements _DRM {
  const _$DRMImpl({this.id = 0, this.name = 'Unknown'});

  factory _$DRMImpl.fromJson(Map<String, dynamic> json) =>
      _$$DRMImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String name;

  @override
  String toString() {
    return 'DRM(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DRMImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of DRM
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DRMImplCopyWith<_$DRMImpl> get copyWith =>
      __$$DRMImplCopyWithImpl<_$DRMImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DRMImplToJson(
      this,
    );
  }
}

abstract class _DRM implements DRM {
  const factory _DRM({final int id, final String name}) = _$DRMImpl;

  factory _DRM.fromJson(Map<String, dynamic> json) = _$DRMImpl.fromJson;

  @override
  int get id;
  @override
  String get name;

  /// Create a copy of DRM
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DRMImplCopyWith<_$DRMImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PriceDetails _$PriceDetailsFromJson(Map<String, dynamic> json) {
  return _PriceDetails.fromJson(json);
}

/// @nodoc
mixin _$PriceDetails {
  @HiveField(0)
  double get amount => throw _privateConstructorUsedError;
  @HiveField(1)
  int get amountInt => throw _privateConstructorUsedError;
  @HiveField(2)
  String get currency => throw _privateConstructorUsedError;

  /// Serializes this PriceDetails to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PriceDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PriceDetailsCopyWith<PriceDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PriceDetailsCopyWith<$Res> {
  factory $PriceDetailsCopyWith(
          PriceDetails value, $Res Function(PriceDetails) then) =
      _$PriceDetailsCopyWithImpl<$Res, PriceDetails>;
  @useResult
  $Res call(
      {@HiveField(0) double amount,
      @HiveField(1) int amountInt,
      @HiveField(2) String currency});
}

/// @nodoc
class _$PriceDetailsCopyWithImpl<$Res, $Val extends PriceDetails>
    implements $PriceDetailsCopyWith<$Res> {
  _$PriceDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PriceDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? amountInt = null,
    Object? currency = null,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      amountInt: null == amountInt
          ? _value.amountInt
          : amountInt // ignore: cast_nullable_to_non_nullable
              as int,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PriceDetailsImplCopyWith<$Res>
    implements $PriceDetailsCopyWith<$Res> {
  factory _$$PriceDetailsImplCopyWith(
          _$PriceDetailsImpl value, $Res Function(_$PriceDetailsImpl) then) =
      __$$PriceDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) double amount,
      @HiveField(1) int amountInt,
      @HiveField(2) String currency});
}

/// @nodoc
class __$$PriceDetailsImplCopyWithImpl<$Res>
    extends _$PriceDetailsCopyWithImpl<$Res, _$PriceDetailsImpl>
    implements _$$PriceDetailsImplCopyWith<$Res> {
  __$$PriceDetailsImplCopyWithImpl(
      _$PriceDetailsImpl _value, $Res Function(_$PriceDetailsImpl) _then)
      : super(_value, _then);

  /// Create a copy of PriceDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? amountInt = null,
    Object? currency = null,
  }) {
    return _then(_$PriceDetailsImpl(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      amountInt: null == amountInt
          ? _value.amountInt
          : amountInt // ignore: cast_nullable_to_non_nullable
              as int,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PriceDetailsImpl extends _PriceDetails {
  const _$PriceDetailsImpl(
      {@HiveField(0) this.amount = 0,
      @HiveField(1) this.amountInt = 0,
      @HiveField(2) this.currency = 'USD'})
      : super._();

  factory _$PriceDetailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PriceDetailsImplFromJson(json);

  @override
  @JsonKey()
  @HiveField(0)
  final double amount;
  @override
  @JsonKey()
  @HiveField(1)
  final int amountInt;
  @override
  @JsonKey()
  @HiveField(2)
  final String currency;

  @override
  String toString() {
    return 'PriceDetails(amount: $amount, amountInt: $amountInt, currency: $currency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PriceDetailsImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.amountInt, amountInt) ||
                other.amountInt == amountInt) &&
            (identical(other.currency, currency) ||
                other.currency == currency));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, amount, amountInt, currency);

  /// Create a copy of PriceDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PriceDetailsImplCopyWith<_$PriceDetailsImpl> get copyWith =>
      __$$PriceDetailsImplCopyWithImpl<_$PriceDetailsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PriceDetailsImplToJson(
      this,
    );
  }
}

abstract class _PriceDetails extends PriceDetails {
  const factory _PriceDetails(
      {@HiveField(0) final double amount,
      @HiveField(1) final int amountInt,
      @HiveField(2) final String currency}) = _$PriceDetailsImpl;
  const _PriceDetails._() : super._();

  factory _PriceDetails.fromJson(Map<String, dynamic> json) =
      _$PriceDetailsImpl.fromJson;

  @override
  @HiveField(0)
  double get amount;
  @override
  @HiveField(1)
  int get amountInt;
  @override
  @HiveField(2)
  String get currency;

  /// Create a copy of PriceDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PriceDetailsImplCopyWith<_$PriceDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Price _$PriceFromJson(Map<String, dynamic> json) {
  return _Price.fromJson(json);
}

/// @nodoc
mixin _$Price {
  @HiveField(0)
  PriceDetails get price => throw _privateConstructorUsedError;
  @HiveField(1)
  PriceDetails get regular => throw _privateConstructorUsedError;
  @HiveField(2)
  double get cut => throw _privateConstructorUsedError;
  @HiveField(3)
  Shop get shop => throw _privateConstructorUsedError;
  List<DRM> get drm => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  @HiveField(4)
  String? get voucher => throw _privateConstructorUsedError;
  @HiveField(5)
  String get timestamp => throw _privateConstructorUsedError;
  @HiveField(6)
  int? get timestampMs => throw _privateConstructorUsedError;

  /// Serializes this Price to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Price
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PriceCopyWith<Price> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PriceCopyWith<$Res> {
  factory $PriceCopyWith(Price value, $Res Function(Price) then) =
      _$PriceCopyWithImpl<$Res, Price>;
  @useResult
  $Res call(
      {@HiveField(0) PriceDetails price,
      @HiveField(1) PriceDetails regular,
      @HiveField(2) double cut,
      @HiveField(3) Shop shop,
      List<DRM> drm,
      String url,
      @HiveField(4) String? voucher,
      @HiveField(5) String timestamp,
      @HiveField(6) int? timestampMs});

  $PriceDetailsCopyWith<$Res> get price;
  $PriceDetailsCopyWith<$Res> get regular;
  $ShopCopyWith<$Res> get shop;
}

/// @nodoc
class _$PriceCopyWithImpl<$Res, $Val extends Price>
    implements $PriceCopyWith<$Res> {
  _$PriceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Price
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? price = null,
    Object? regular = null,
    Object? cut = null,
    Object? shop = null,
    Object? drm = null,
    Object? url = null,
    Object? voucher = freezed,
    Object? timestamp = null,
    Object? timestampMs = freezed,
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
      shop: null == shop
          ? _value.shop
          : shop // ignore: cast_nullable_to_non_nullable
              as Shop,
      drm: null == drm
          ? _value.drm
          : drm // ignore: cast_nullable_to_non_nullable
              as List<DRM>,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      voucher: freezed == voucher
          ? _value.voucher
          : voucher // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
      timestampMs: freezed == timestampMs
          ? _value.timestampMs
          : timestampMs // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  /// Create a copy of Price
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PriceDetailsCopyWith<$Res> get price {
    return $PriceDetailsCopyWith<$Res>(_value.price, (value) {
      return _then(_value.copyWith(price: value) as $Val);
    });
  }

  /// Create a copy of Price
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PriceDetailsCopyWith<$Res> get regular {
    return $PriceDetailsCopyWith<$Res>(_value.regular, (value) {
      return _then(_value.copyWith(regular: value) as $Val);
    });
  }

  /// Create a copy of Price
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ShopCopyWith<$Res> get shop {
    return $ShopCopyWith<$Res>(_value.shop, (value) {
      return _then(_value.copyWith(shop: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PriceImplCopyWith<$Res> implements $PriceCopyWith<$Res> {
  factory _$$PriceImplCopyWith(
          _$PriceImpl value, $Res Function(_$PriceImpl) then) =
      __$$PriceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) PriceDetails price,
      @HiveField(1) PriceDetails regular,
      @HiveField(2) double cut,
      @HiveField(3) Shop shop,
      List<DRM> drm,
      String url,
      @HiveField(4) String? voucher,
      @HiveField(5) String timestamp,
      @HiveField(6) int? timestampMs});

  @override
  $PriceDetailsCopyWith<$Res> get price;
  @override
  $PriceDetailsCopyWith<$Res> get regular;
  @override
  $ShopCopyWith<$Res> get shop;
}

/// @nodoc
class __$$PriceImplCopyWithImpl<$Res>
    extends _$PriceCopyWithImpl<$Res, _$PriceImpl>
    implements _$$PriceImplCopyWith<$Res> {
  __$$PriceImplCopyWithImpl(
      _$PriceImpl _value, $Res Function(_$PriceImpl) _then)
      : super(_value, _then);

  /// Create a copy of Price
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? price = null,
    Object? regular = null,
    Object? cut = null,
    Object? shop = null,
    Object? drm = null,
    Object? url = null,
    Object? voucher = freezed,
    Object? timestamp = null,
    Object? timestampMs = freezed,
  }) {
    return _then(_$PriceImpl(
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
      shop: null == shop
          ? _value.shop
          : shop // ignore: cast_nullable_to_non_nullable
              as Shop,
      drm: null == drm
          ? _value._drm
          : drm // ignore: cast_nullable_to_non_nullable
              as List<DRM>,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      voucher: freezed == voucher
          ? _value.voucher
          : voucher // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
      timestampMs: freezed == timestampMs
          ? _value.timestampMs
          : timestampMs // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PriceImpl extends _Price {
  const _$PriceImpl(
      {@HiveField(0) required this.price,
      @HiveField(1) required this.regular,
      @HiveField(2) this.cut = 0,
      @HiveField(3) required this.shop,
      final List<DRM> drm = const [],
      this.url = '',
      @HiveField(4) this.voucher,
      @HiveField(5) this.timestamp = '',
      @HiveField(6) this.timestampMs})
      : _drm = drm,
        super._();

  factory _$PriceImpl.fromJson(Map<String, dynamic> json) =>
      _$$PriceImplFromJson(json);

  @override
  @HiveField(0)
  final PriceDetails price;
  @override
  @HiveField(1)
  final PriceDetails regular;
  @override
  @JsonKey()
  @HiveField(2)
  final double cut;
  @override
  @HiveField(3)
  final Shop shop;
  final List<DRM> _drm;
  @override
  @JsonKey()
  List<DRM> get drm {
    if (_drm is EqualUnmodifiableListView) return _drm;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_drm);
  }

  @override
  @JsonKey()
  final String url;
  @override
  @HiveField(4)
  final String? voucher;
  @override
  @JsonKey()
  @HiveField(5)
  final String timestamp;
  @override
  @HiveField(6)
  final int? timestampMs;

  @override
  String toString() {
    return 'Price(price: $price, regular: $regular, cut: $cut, shop: $shop, drm: $drm, url: $url, voucher: $voucher, timestamp: $timestamp, timestampMs: $timestampMs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PriceImpl &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.regular, regular) || other.regular == regular) &&
            (identical(other.cut, cut) || other.cut == cut) &&
            (identical(other.shop, shop) || other.shop == shop) &&
            const DeepCollectionEquality().equals(other._drm, _drm) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.voucher, voucher) || other.voucher == voucher) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.timestampMs, timestampMs) ||
                other.timestampMs == timestampMs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      price,
      regular,
      cut,
      shop,
      const DeepCollectionEquality().hash(_drm),
      url,
      voucher,
      timestamp,
      timestampMs);

  /// Create a copy of Price
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PriceImplCopyWith<_$PriceImpl> get copyWith =>
      __$$PriceImplCopyWithImpl<_$PriceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PriceImplToJson(
      this,
    );
  }
}

abstract class _Price extends Price {
  const factory _Price(
      {@HiveField(0) required final PriceDetails price,
      @HiveField(1) required final PriceDetails regular,
      @HiveField(2) final double cut,
      @HiveField(3) required final Shop shop,
      final List<DRM> drm,
      final String url,
      @HiveField(4) final String? voucher,
      @HiveField(5) final String timestamp,
      @HiveField(6) final int? timestampMs}) = _$PriceImpl;
  const _Price._() : super._();

  factory _Price.fromJson(Map<String, dynamic> json) = _$PriceImpl.fromJson;

  @override
  @HiveField(0)
  PriceDetails get price;
  @override
  @HiveField(1)
  PriceDetails get regular;
  @override
  @HiveField(2)
  double get cut;
  @override
  @HiveField(3)
  Shop get shop;
  @override
  List<DRM> get drm;
  @override
  String get url;
  @override
  @HiveField(4)
  String? get voucher;
  @override
  @HiveField(5)
  String get timestamp;
  @override
  @HiveField(6)
  int? get timestampMs;

  /// Create a copy of Price
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PriceImplCopyWith<_$PriceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
