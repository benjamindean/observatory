// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'overview.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Overview _$OverviewFromJson(Map<String, dynamic> json) {
  return _Overview.fromJson(json);
}

/// @nodoc
mixin _$Overview {
  List<OverviewPrices>? get prices => throw _privateConstructorUsedError;
  List<Bundle>? get bundles => throw _privateConstructorUsedError;

  /// Serializes this Overview to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Overview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OverviewCopyWith<Overview> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OverviewCopyWith<$Res> {
  factory $OverviewCopyWith(Overview value, $Res Function(Overview) then) =
      _$OverviewCopyWithImpl<$Res, Overview>;
  @useResult
  $Res call({List<OverviewPrices>? prices, List<Bundle>? bundles});
}

/// @nodoc
class _$OverviewCopyWithImpl<$Res, $Val extends Overview>
    implements $OverviewCopyWith<$Res> {
  _$OverviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Overview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? prices = freezed,
    Object? bundles = freezed,
  }) {
    return _then(_value.copyWith(
      prices: freezed == prices
          ? _value.prices
          : prices // ignore: cast_nullable_to_non_nullable
              as List<OverviewPrices>?,
      bundles: freezed == bundles
          ? _value.bundles
          : bundles // ignore: cast_nullable_to_non_nullable
              as List<Bundle>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OverviewImplCopyWith<$Res>
    implements $OverviewCopyWith<$Res> {
  factory _$$OverviewImplCopyWith(
          _$OverviewImpl value, $Res Function(_$OverviewImpl) then) =
      __$$OverviewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<OverviewPrices>? prices, List<Bundle>? bundles});
}

/// @nodoc
class __$$OverviewImplCopyWithImpl<$Res>
    extends _$OverviewCopyWithImpl<$Res, _$OverviewImpl>
    implements _$$OverviewImplCopyWith<$Res> {
  __$$OverviewImplCopyWithImpl(
      _$OverviewImpl _value, $Res Function(_$OverviewImpl) _then)
      : super(_value, _then);

  /// Create a copy of Overview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? prices = freezed,
    Object? bundles = freezed,
  }) {
    return _then(_$OverviewImpl(
      prices: freezed == prices
          ? _value._prices
          : prices // ignore: cast_nullable_to_non_nullable
              as List<OverviewPrices>?,
      bundles: freezed == bundles
          ? _value._bundles
          : bundles // ignore: cast_nullable_to_non_nullable
              as List<Bundle>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OverviewImpl with DiagnosticableTreeMixin implements _Overview {
  const _$OverviewImpl(
      {final List<OverviewPrices>? prices = const [],
      final List<Bundle>? bundles = const []})
      : _prices = prices,
        _bundles = bundles;

  factory _$OverviewImpl.fromJson(Map<String, dynamic> json) =>
      _$$OverviewImplFromJson(json);

  final List<OverviewPrices>? _prices;
  @override
  @JsonKey()
  List<OverviewPrices>? get prices {
    final value = _prices;
    if (value == null) return null;
    if (_prices is EqualUnmodifiableListView) return _prices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Bundle>? _bundles;
  @override
  @JsonKey()
  List<Bundle>? get bundles {
    final value = _bundles;
    if (value == null) return null;
    if (_bundles is EqualUnmodifiableListView) return _bundles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Overview(prices: $prices, bundles: $bundles)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Overview'))
      ..add(DiagnosticsProperty('prices', prices))
      ..add(DiagnosticsProperty('bundles', bundles));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OverviewImpl &&
            const DeepCollectionEquality().equals(other._prices, _prices) &&
            const DeepCollectionEquality().equals(other._bundles, _bundles));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_prices),
      const DeepCollectionEquality().hash(_bundles));

  /// Create a copy of Overview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OverviewImplCopyWith<_$OverviewImpl> get copyWith =>
      __$$OverviewImplCopyWithImpl<_$OverviewImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OverviewImplToJson(
      this,
    );
  }
}

abstract class _Overview implements Overview {
  const factory _Overview(
      {final List<OverviewPrices>? prices,
      final List<Bundle>? bundles}) = _$OverviewImpl;

  factory _Overview.fromJson(Map<String, dynamic> json) =
      _$OverviewImpl.fromJson;

  @override
  List<OverviewPrices>? get prices;
  @override
  List<Bundle>? get bundles;

  /// Create a copy of Overview
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OverviewImplCopyWith<_$OverviewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OverviewPrices _$OverviewPricesFromJson(Map<String, dynamic> json) {
  return _OverviewPrices.fromJson(json);
}

/// @nodoc
mixin _$OverviewPrices {
  String get id => throw _privateConstructorUsedError;
  Price? get current => throw _privateConstructorUsedError;
  Price? get lowest => throw _privateConstructorUsedError;

  /// Serializes this OverviewPrices to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OverviewPrices
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OverviewPricesCopyWith<OverviewPrices> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OverviewPricesCopyWith<$Res> {
  factory $OverviewPricesCopyWith(
          OverviewPrices value, $Res Function(OverviewPrices) then) =
      _$OverviewPricesCopyWithImpl<$Res, OverviewPrices>;
  @useResult
  $Res call({String id, Price? current, Price? lowest});

  $PriceCopyWith<$Res>? get current;
  $PriceCopyWith<$Res>? get lowest;
}

/// @nodoc
class _$OverviewPricesCopyWithImpl<$Res, $Val extends OverviewPrices>
    implements $OverviewPricesCopyWith<$Res> {
  _$OverviewPricesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OverviewPrices
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? current = freezed,
    Object? lowest = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      current: freezed == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as Price?,
      lowest: freezed == lowest
          ? _value.lowest
          : lowest // ignore: cast_nullable_to_non_nullable
              as Price?,
    ) as $Val);
  }

  /// Create a copy of OverviewPrices
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PriceCopyWith<$Res>? get current {
    if (_value.current == null) {
      return null;
    }

    return $PriceCopyWith<$Res>(_value.current!, (value) {
      return _then(_value.copyWith(current: value) as $Val);
    });
  }

  /// Create a copy of OverviewPrices
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PriceCopyWith<$Res>? get lowest {
    if (_value.lowest == null) {
      return null;
    }

    return $PriceCopyWith<$Res>(_value.lowest!, (value) {
      return _then(_value.copyWith(lowest: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OverviewPricesImplCopyWith<$Res>
    implements $OverviewPricesCopyWith<$Res> {
  factory _$$OverviewPricesImplCopyWith(_$OverviewPricesImpl value,
          $Res Function(_$OverviewPricesImpl) then) =
      __$$OverviewPricesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, Price? current, Price? lowest});

  @override
  $PriceCopyWith<$Res>? get current;
  @override
  $PriceCopyWith<$Res>? get lowest;
}

/// @nodoc
class __$$OverviewPricesImplCopyWithImpl<$Res>
    extends _$OverviewPricesCopyWithImpl<$Res, _$OverviewPricesImpl>
    implements _$$OverviewPricesImplCopyWith<$Res> {
  __$$OverviewPricesImplCopyWithImpl(
      _$OverviewPricesImpl _value, $Res Function(_$OverviewPricesImpl) _then)
      : super(_value, _then);

  /// Create a copy of OverviewPrices
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? current = freezed,
    Object? lowest = freezed,
  }) {
    return _then(_$OverviewPricesImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      current: freezed == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as Price?,
      lowest: freezed == lowest
          ? _value.lowest
          : lowest // ignore: cast_nullable_to_non_nullable
              as Price?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OverviewPricesImpl
    with DiagnosticableTreeMixin
    implements _OverviewPrices {
  const _$OverviewPricesImpl({required this.id, this.current, this.lowest});

  factory _$OverviewPricesImpl.fromJson(Map<String, dynamic> json) =>
      _$$OverviewPricesImplFromJson(json);

  @override
  final String id;
  @override
  final Price? current;
  @override
  final Price? lowest;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'OverviewPrices(id: $id, current: $current, lowest: $lowest)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'OverviewPrices'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('current', current))
      ..add(DiagnosticsProperty('lowest', lowest));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OverviewPricesImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.current, current) || other.current == current) &&
            (identical(other.lowest, lowest) || other.lowest == lowest));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, current, lowest);

  /// Create a copy of OverviewPrices
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OverviewPricesImplCopyWith<_$OverviewPricesImpl> get copyWith =>
      __$$OverviewPricesImplCopyWithImpl<_$OverviewPricesImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OverviewPricesImplToJson(
      this,
    );
  }
}

abstract class _OverviewPrices implements OverviewPrices {
  const factory _OverviewPrices(
      {required final String id,
      final Price? current,
      final Price? lowest}) = _$OverviewPricesImpl;

  factory _OverviewPrices.fromJson(Map<String, dynamic> json) =
      _$OverviewPricesImpl.fromJson;

  @override
  String get id;
  @override
  Price? get current;
  @override
  Price? get lowest;

  /// Create a copy of OverviewPrices
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OverviewPricesImplCopyWith<_$OverviewPricesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Bundle _$BundleFromJson(Map<String, dynamic> json) {
  return _Bundle.fromJson(json);
}

/// @nodoc
mixin _$Bundle {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get details => throw _privateConstructorUsedError;
  BundlePage get page => throw _privateConstructorUsedError;
  String? get expiry => throw _privateConstructorUsedError;

  /// Serializes this Bundle to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Bundle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BundleCopyWith<Bundle> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BundleCopyWith<$Res> {
  factory $BundleCopyWith(Bundle value, $Res Function(Bundle) then) =
      _$BundleCopyWithImpl<$Res, Bundle>;
  @useResult
  $Res call(
      {int id,
      String title,
      String url,
      String details,
      BundlePage page,
      String? expiry});

  $BundlePageCopyWith<$Res> get page;
}

/// @nodoc
class _$BundleCopyWithImpl<$Res, $Val extends Bundle>
    implements $BundleCopyWith<$Res> {
  _$BundleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Bundle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? url = null,
    Object? details = null,
    Object? page = null,
    Object? expiry = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      details: null == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as String,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as BundlePage,
      expiry: freezed == expiry
          ? _value.expiry
          : expiry // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of Bundle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BundlePageCopyWith<$Res> get page {
    return $BundlePageCopyWith<$Res>(_value.page, (value) {
      return _then(_value.copyWith(page: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BundleImplCopyWith<$Res> implements $BundleCopyWith<$Res> {
  factory _$$BundleImplCopyWith(
          _$BundleImpl value, $Res Function(_$BundleImpl) then) =
      __$$BundleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String url,
      String details,
      BundlePage page,
      String? expiry});

  @override
  $BundlePageCopyWith<$Res> get page;
}

/// @nodoc
class __$$BundleImplCopyWithImpl<$Res>
    extends _$BundleCopyWithImpl<$Res, _$BundleImpl>
    implements _$$BundleImplCopyWith<$Res> {
  __$$BundleImplCopyWithImpl(
      _$BundleImpl _value, $Res Function(_$BundleImpl) _then)
      : super(_value, _then);

  /// Create a copy of Bundle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? url = null,
    Object? details = null,
    Object? page = null,
    Object? expiry = freezed,
  }) {
    return _then(_$BundleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      details: null == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as String,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as BundlePage,
      expiry: freezed == expiry
          ? _value.expiry
          : expiry // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BundleImpl extends _Bundle with DiagnosticableTreeMixin {
  const _$BundleImpl(
      {required this.id,
      required this.title,
      required this.url,
      required this.details,
      required this.page,
      this.expiry})
      : super._();

  factory _$BundleImpl.fromJson(Map<String, dynamic> json) =>
      _$$BundleImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String url;
  @override
  final String details;
  @override
  final BundlePage page;
  @override
  final String? expiry;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Bundle(id: $id, title: $title, url: $url, details: $details, page: $page, expiry: $expiry)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Bundle'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('url', url))
      ..add(DiagnosticsProperty('details', details))
      ..add(DiagnosticsProperty('page', page))
      ..add(DiagnosticsProperty('expiry', expiry));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BundleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.details, details) || other.details == details) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.expiry, expiry) || other.expiry == expiry));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, url, details, page, expiry);

  /// Create a copy of Bundle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BundleImplCopyWith<_$BundleImpl> get copyWith =>
      __$$BundleImplCopyWithImpl<_$BundleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BundleImplToJson(
      this,
    );
  }
}

abstract class _Bundle extends Bundle {
  const factory _Bundle(
      {required final int id,
      required final String title,
      required final String url,
      required final String details,
      required final BundlePage page,
      final String? expiry}) = _$BundleImpl;
  const _Bundle._() : super._();

  factory _Bundle.fromJson(Map<String, dynamic> json) = _$BundleImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get url;
  @override
  String get details;
  @override
  BundlePage get page;
  @override
  String? get expiry;

  /// Create a copy of Bundle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BundleImplCopyWith<_$BundleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BundlePage _$BundlePageFromJson(Map<String, dynamic> json) {
  return _BundlePage.fromJson(json);
}

/// @nodoc
mixin _$BundlePage {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this BundlePage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BundlePage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BundlePageCopyWith<BundlePage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BundlePageCopyWith<$Res> {
  factory $BundlePageCopyWith(
          BundlePage value, $Res Function(BundlePage) then) =
      _$BundlePageCopyWithImpl<$Res, BundlePage>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$BundlePageCopyWithImpl<$Res, $Val extends BundlePage>
    implements $BundlePageCopyWith<$Res> {
  _$BundlePageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BundlePage
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
abstract class _$$BundlePageImplCopyWith<$Res>
    implements $BundlePageCopyWith<$Res> {
  factory _$$BundlePageImplCopyWith(
          _$BundlePageImpl value, $Res Function(_$BundlePageImpl) then) =
      __$$BundlePageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$BundlePageImplCopyWithImpl<$Res>
    extends _$BundlePageCopyWithImpl<$Res, _$BundlePageImpl>
    implements _$$BundlePageImplCopyWith<$Res> {
  __$$BundlePageImplCopyWithImpl(
      _$BundlePageImpl _value, $Res Function(_$BundlePageImpl) _then)
      : super(_value, _then);

  /// Create a copy of BundlePage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$BundlePageImpl(
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
class _$BundlePageImpl with DiagnosticableTreeMixin implements _BundlePage {
  const _$BundlePageImpl({required this.id, required this.name});

  factory _$BundlePageImpl.fromJson(Map<String, dynamic> json) =>
      _$$BundlePageImplFromJson(json);

  @override
  final int id;
  @override
  final String name;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BundlePage(id: $id, name: $name)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BundlePage'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BundlePageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of BundlePage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BundlePageImplCopyWith<_$BundlePageImpl> get copyWith =>
      __$$BundlePageImplCopyWithImpl<_$BundlePageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BundlePageImplToJson(
      this,
    );
  }
}

abstract class _BundlePage implements BundlePage {
  const factory _BundlePage(
      {required final int id, required final String name}) = _$BundlePageImpl;

  factory _BundlePage.fromJson(Map<String, dynamic> json) =
      _$BundlePageImpl.fromJson;

  @override
  int get id;
  @override
  String get name;

  /// Create a copy of BundlePage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BundlePageImplCopyWith<_$BundlePageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
