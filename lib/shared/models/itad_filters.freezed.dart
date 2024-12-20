// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'itad_filters.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MinMax _$MinMaxFromJson(Map<String, dynamic> json) {
  return _MinMax.fromJson(json);
}

/// @nodoc
mixin _$MinMax {
  @HiveField(0)
  int get min => throw _privateConstructorUsedError;
  @HiveField(1)
  int get max => throw _privateConstructorUsedError;

  /// Serializes this MinMax to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MinMax
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MinMaxCopyWith<MinMax> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MinMaxCopyWith<$Res> {
  factory $MinMaxCopyWith(MinMax value, $Res Function(MinMax) then) =
      _$MinMaxCopyWithImpl<$Res, MinMax>;
  @useResult
  $Res call({@HiveField(0) int min, @HiveField(1) int max});
}

/// @nodoc
class _$MinMaxCopyWithImpl<$Res, $Val extends MinMax>
    implements $MinMaxCopyWith<$Res> {
  _$MinMaxCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MinMax
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? min = null,
    Object? max = null,
  }) {
    return _then(_value.copyWith(
      min: null == min
          ? _value.min
          : min // ignore: cast_nullable_to_non_nullable
              as int,
      max: null == max
          ? _value.max
          : max // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MinMaxImplCopyWith<$Res> implements $MinMaxCopyWith<$Res> {
  factory _$$MinMaxImplCopyWith(
          _$MinMaxImpl value, $Res Function(_$MinMaxImpl) then) =
      __$$MinMaxImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@HiveField(0) int min, @HiveField(1) int max});
}

/// @nodoc
class __$$MinMaxImplCopyWithImpl<$Res>
    extends _$MinMaxCopyWithImpl<$Res, _$MinMaxImpl>
    implements _$$MinMaxImplCopyWith<$Res> {
  __$$MinMaxImplCopyWithImpl(
      _$MinMaxImpl _value, $Res Function(_$MinMaxImpl) _then)
      : super(_value, _then);

  /// Create a copy of MinMax
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? min = null,
    Object? max = null,
  }) {
    return _then(_$MinMaxImpl(
      min: null == min
          ? _value.min
          : min // ignore: cast_nullable_to_non_nullable
              as int,
      max: null == max
          ? _value.max
          : max // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MinMaxImpl with DiagnosticableTreeMixin implements _MinMax {
  const _$MinMaxImpl(
      {@HiveField(0) this.min = 0, @HiveField(1) this.max = 100});

  factory _$MinMaxImpl.fromJson(Map<String, dynamic> json) =>
      _$$MinMaxImplFromJson(json);

  @override
  @JsonKey()
  @HiveField(0)
  final int min;
  @override
  @JsonKey()
  @HiveField(1)
  final int max;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MinMax(min: $min, max: $max)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MinMax'))
      ..add(DiagnosticsProperty('min', min))
      ..add(DiagnosticsProperty('max', max));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MinMaxImpl &&
            (identical(other.min, min) || other.min == min) &&
            (identical(other.max, max) || other.max == max));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, min, max);

  /// Create a copy of MinMax
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MinMaxImplCopyWith<_$MinMaxImpl> get copyWith =>
      __$$MinMaxImplCopyWithImpl<_$MinMaxImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MinMaxImplToJson(
      this,
    );
  }
}

abstract class _MinMax implements MinMax {
  const factory _MinMax(
      {@HiveField(0) final int min,
      @HiveField(1) final int max}) = _$MinMaxImpl;

  factory _MinMax.fromJson(Map<String, dynamic> json) = _$MinMaxImpl.fromJson;

  @override
  @HiveField(0)
  int get min;
  @override
  @HiveField(1)
  int get max;

  /// Create a copy of MinMax
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MinMaxImplCopyWith<_$MinMaxImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ITADFilters _$ITADFiltersFromJson(Map<String, dynamic> json) {
  return _ITADFilters.fromJson(json);
}

/// @nodoc
mixin _$ITADFilters {
  @HiveField(0)
  MinMax? get price => throw _privateConstructorUsedError;
  @HiveField(1)
  MinMax? get cut => throw _privateConstructorUsedError;
  @HiveField(2)
  bool? get bundled => throw _privateConstructorUsedError;
  @HiveField(3)
  List<String>? get tags => throw _privateConstructorUsedError;
  @HiveField(4)
  bool get mature => throw _privateConstructorUsedError;
  @HiveField(5)
  bool get nondeals => throw _privateConstructorUsedError;
  @HiveField(6)
  List<int>? get platform => throw _privateConstructorUsedError;
  @HiveField(7)
  String? get sortBy => throw _privateConstructorUsedError;

  /// Serializes this ITADFilters to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ITADFilters
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ITADFiltersCopyWith<ITADFilters> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ITADFiltersCopyWith<$Res> {
  factory $ITADFiltersCopyWith(
          ITADFilters value, $Res Function(ITADFilters) then) =
      _$ITADFiltersCopyWithImpl<$Res, ITADFilters>;
  @useResult
  $Res call(
      {@HiveField(0) MinMax? price,
      @HiveField(1) MinMax? cut,
      @HiveField(2) bool? bundled,
      @HiveField(3) List<String>? tags,
      @HiveField(4) bool mature,
      @HiveField(5) bool nondeals,
      @HiveField(6) List<int>? platform,
      @HiveField(7) String? sortBy});

  $MinMaxCopyWith<$Res>? get price;
  $MinMaxCopyWith<$Res>? get cut;
}

/// @nodoc
class _$ITADFiltersCopyWithImpl<$Res, $Val extends ITADFilters>
    implements $ITADFiltersCopyWith<$Res> {
  _$ITADFiltersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ITADFilters
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? price = freezed,
    Object? cut = freezed,
    Object? bundled = freezed,
    Object? tags = freezed,
    Object? mature = null,
    Object? nondeals = null,
    Object? platform = freezed,
    Object? sortBy = freezed,
  }) {
    return _then(_value.copyWith(
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as MinMax?,
      cut: freezed == cut
          ? _value.cut
          : cut // ignore: cast_nullable_to_non_nullable
              as MinMax?,
      bundled: freezed == bundled
          ? _value.bundled
          : bundled // ignore: cast_nullable_to_non_nullable
              as bool?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      mature: null == mature
          ? _value.mature
          : mature // ignore: cast_nullable_to_non_nullable
              as bool,
      nondeals: null == nondeals
          ? _value.nondeals
          : nondeals // ignore: cast_nullable_to_non_nullable
              as bool,
      platform: freezed == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      sortBy: freezed == sortBy
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of ITADFilters
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MinMaxCopyWith<$Res>? get price {
    if (_value.price == null) {
      return null;
    }

    return $MinMaxCopyWith<$Res>(_value.price!, (value) {
      return _then(_value.copyWith(price: value) as $Val);
    });
  }

  /// Create a copy of ITADFilters
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MinMaxCopyWith<$Res>? get cut {
    if (_value.cut == null) {
      return null;
    }

    return $MinMaxCopyWith<$Res>(_value.cut!, (value) {
      return _then(_value.copyWith(cut: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ITADFiltersImplCopyWith<$Res>
    implements $ITADFiltersCopyWith<$Res> {
  factory _$$ITADFiltersImplCopyWith(
          _$ITADFiltersImpl value, $Res Function(_$ITADFiltersImpl) then) =
      __$$ITADFiltersImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) MinMax? price,
      @HiveField(1) MinMax? cut,
      @HiveField(2) bool? bundled,
      @HiveField(3) List<String>? tags,
      @HiveField(4) bool mature,
      @HiveField(5) bool nondeals,
      @HiveField(6) List<int>? platform,
      @HiveField(7) String? sortBy});

  @override
  $MinMaxCopyWith<$Res>? get price;
  @override
  $MinMaxCopyWith<$Res>? get cut;
}

/// @nodoc
class __$$ITADFiltersImplCopyWithImpl<$Res>
    extends _$ITADFiltersCopyWithImpl<$Res, _$ITADFiltersImpl>
    implements _$$ITADFiltersImplCopyWith<$Res> {
  __$$ITADFiltersImplCopyWithImpl(
      _$ITADFiltersImpl _value, $Res Function(_$ITADFiltersImpl) _then)
      : super(_value, _then);

  /// Create a copy of ITADFilters
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? price = freezed,
    Object? cut = freezed,
    Object? bundled = freezed,
    Object? tags = freezed,
    Object? mature = null,
    Object? nondeals = null,
    Object? platform = freezed,
    Object? sortBy = freezed,
  }) {
    return _then(_$ITADFiltersImpl(
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as MinMax?,
      cut: freezed == cut
          ? _value.cut
          : cut // ignore: cast_nullable_to_non_nullable
              as MinMax?,
      bundled: freezed == bundled
          ? _value.bundled
          : bundled // ignore: cast_nullable_to_non_nullable
              as bool?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      mature: null == mature
          ? _value.mature
          : mature // ignore: cast_nullable_to_non_nullable
              as bool,
      nondeals: null == nondeals
          ? _value.nondeals
          : nondeals // ignore: cast_nullable_to_non_nullable
              as bool,
      platform: freezed == platform
          ? _value._platform
          : platform // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      sortBy: freezed == sortBy
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$ITADFiltersImpl extends _ITADFilters with DiagnosticableTreeMixin {
  const _$ITADFiltersImpl(
      {@HiveField(0) this.price,
      @HiveField(1) this.cut,
      @HiveField(2) this.bundled,
      @HiveField(3) final List<String>? tags,
      @HiveField(4) this.mature = false,
      @HiveField(5) this.nondeals = true,
      @HiveField(6) final List<int>? platform,
      @HiveField(7) this.sortBy = 'trending'})
      : _tags = tags,
        _platform = platform,
        super._();

  factory _$ITADFiltersImpl.fromJson(Map<String, dynamic> json) =>
      _$$ITADFiltersImplFromJson(json);

  @override
  @HiveField(0)
  final MinMax? price;
  @override
  @HiveField(1)
  final MinMax? cut;
  @override
  @HiveField(2)
  final bool? bundled;
  final List<String>? _tags;
  @override
  @HiveField(3)
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  @HiveField(4)
  final bool mature;
  @override
  @JsonKey()
  @HiveField(5)
  final bool nondeals;
  final List<int>? _platform;
  @override
  @HiveField(6)
  List<int>? get platform {
    final value = _platform;
    if (value == null) return null;
    if (_platform is EqualUnmodifiableListView) return _platform;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  @HiveField(7)
  final String? sortBy;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ITADFilters(price: $price, cut: $cut, bundled: $bundled, tags: $tags, mature: $mature, nondeals: $nondeals, platform: $platform, sortBy: $sortBy)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ITADFilters'))
      ..add(DiagnosticsProperty('price', price))
      ..add(DiagnosticsProperty('cut', cut))
      ..add(DiagnosticsProperty('bundled', bundled))
      ..add(DiagnosticsProperty('tags', tags))
      ..add(DiagnosticsProperty('mature', mature))
      ..add(DiagnosticsProperty('nondeals', nondeals))
      ..add(DiagnosticsProperty('platform', platform))
      ..add(DiagnosticsProperty('sortBy', sortBy));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ITADFiltersImpl &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.cut, cut) || other.cut == cut) &&
            (identical(other.bundled, bundled) || other.bundled == bundled) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.mature, mature) || other.mature == mature) &&
            (identical(other.nondeals, nondeals) ||
                other.nondeals == nondeals) &&
            const DeepCollectionEquality().equals(other._platform, _platform) &&
            (identical(other.sortBy, sortBy) || other.sortBy == sortBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      price,
      cut,
      bundled,
      const DeepCollectionEquality().hash(_tags),
      mature,
      nondeals,
      const DeepCollectionEquality().hash(_platform),
      sortBy);

  /// Create a copy of ITADFilters
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ITADFiltersImplCopyWith<_$ITADFiltersImpl> get copyWith =>
      __$$ITADFiltersImplCopyWithImpl<_$ITADFiltersImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ITADFiltersImplToJson(
      this,
    );
  }
}

abstract class _ITADFilters extends ITADFilters {
  const factory _ITADFilters(
      {@HiveField(0) final MinMax? price,
      @HiveField(1) final MinMax? cut,
      @HiveField(2) final bool? bundled,
      @HiveField(3) final List<String>? tags,
      @HiveField(4) final bool mature,
      @HiveField(5) final bool nondeals,
      @HiveField(6) final List<int>? platform,
      @HiveField(7) final String? sortBy}) = _$ITADFiltersImpl;
  const _ITADFilters._() : super._();

  factory _ITADFilters.fromJson(Map<String, dynamic> json) =
      _$ITADFiltersImpl.fromJson;

  @override
  @HiveField(0)
  MinMax? get price;
  @override
  @HiveField(1)
  MinMax? get cut;
  @override
  @HiveField(2)
  bool? get bundled;
  @override
  @HiveField(3)
  List<String>? get tags;
  @override
  @HiveField(4)
  bool get mature;
  @override
  @HiveField(5)
  bool get nondeals;
  @override
  @HiveField(6)
  List<int>? get platform;
  @override
  @HiveField(7)
  String? get sortBy;

  /// Create a copy of ITADFilters
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ITADFiltersImplCopyWith<_$ITADFiltersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ITADFiltersConfig _$ITADFiltersConfigFromJson(Map<String, dynamic> json) {
  return _ITADFiltersConfig.fromJson(json);
}

/// @nodoc
mixin _$ITADFiltersConfig {
  ITADFilters get cached => throw _privateConstructorUsedError;
  ITADFilters get current => throw _privateConstructorUsedError;

  /// Serializes this ITADFiltersConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ITADFiltersConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ITADFiltersConfigCopyWith<ITADFiltersConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ITADFiltersConfigCopyWith<$Res> {
  factory $ITADFiltersConfigCopyWith(
          ITADFiltersConfig value, $Res Function(ITADFiltersConfig) then) =
      _$ITADFiltersConfigCopyWithImpl<$Res, ITADFiltersConfig>;
  @useResult
  $Res call({ITADFilters cached, ITADFilters current});

  $ITADFiltersCopyWith<$Res> get cached;
  $ITADFiltersCopyWith<$Res> get current;
}

/// @nodoc
class _$ITADFiltersConfigCopyWithImpl<$Res, $Val extends ITADFiltersConfig>
    implements $ITADFiltersConfigCopyWith<$Res> {
  _$ITADFiltersConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ITADFiltersConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cached = null,
    Object? current = null,
  }) {
    return _then(_value.copyWith(
      cached: null == cached
          ? _value.cached
          : cached // ignore: cast_nullable_to_non_nullable
              as ITADFilters,
      current: null == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as ITADFilters,
    ) as $Val);
  }

  /// Create a copy of ITADFiltersConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ITADFiltersCopyWith<$Res> get cached {
    return $ITADFiltersCopyWith<$Res>(_value.cached, (value) {
      return _then(_value.copyWith(cached: value) as $Val);
    });
  }

  /// Create a copy of ITADFiltersConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ITADFiltersCopyWith<$Res> get current {
    return $ITADFiltersCopyWith<$Res>(_value.current, (value) {
      return _then(_value.copyWith(current: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ITADFiltersConfigImplCopyWith<$Res>
    implements $ITADFiltersConfigCopyWith<$Res> {
  factory _$$ITADFiltersConfigImplCopyWith(_$ITADFiltersConfigImpl value,
          $Res Function(_$ITADFiltersConfigImpl) then) =
      __$$ITADFiltersConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ITADFilters cached, ITADFilters current});

  @override
  $ITADFiltersCopyWith<$Res> get cached;
  @override
  $ITADFiltersCopyWith<$Res> get current;
}

/// @nodoc
class __$$ITADFiltersConfigImplCopyWithImpl<$Res>
    extends _$ITADFiltersConfigCopyWithImpl<$Res, _$ITADFiltersConfigImpl>
    implements _$$ITADFiltersConfigImplCopyWith<$Res> {
  __$$ITADFiltersConfigImplCopyWithImpl(_$ITADFiltersConfigImpl _value,
      $Res Function(_$ITADFiltersConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of ITADFiltersConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cached = null,
    Object? current = null,
  }) {
    return _then(_$ITADFiltersConfigImpl(
      cached: null == cached
          ? _value.cached
          : cached // ignore: cast_nullable_to_non_nullable
              as ITADFilters,
      current: null == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as ITADFilters,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ITADFiltersConfigImpl extends _ITADFiltersConfig
    with DiagnosticableTreeMixin {
  const _$ITADFiltersConfigImpl({required this.cached, required this.current})
      : super._();

  factory _$ITADFiltersConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$ITADFiltersConfigImplFromJson(json);

  @override
  final ITADFilters cached;
  @override
  final ITADFilters current;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ITADFiltersConfig(cached: $cached, current: $current)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ITADFiltersConfig'))
      ..add(DiagnosticsProperty('cached', cached))
      ..add(DiagnosticsProperty('current', current));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ITADFiltersConfigImpl &&
            (identical(other.cached, cached) || other.cached == cached) &&
            (identical(other.current, current) || other.current == current));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, cached, current);

  /// Create a copy of ITADFiltersConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ITADFiltersConfigImplCopyWith<_$ITADFiltersConfigImpl> get copyWith =>
      __$$ITADFiltersConfigImplCopyWithImpl<_$ITADFiltersConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ITADFiltersConfigImplToJson(
      this,
    );
  }
}

abstract class _ITADFiltersConfig extends ITADFiltersConfig {
  const factory _ITADFiltersConfig(
      {required final ITADFilters cached,
      required final ITADFilters current}) = _$ITADFiltersConfigImpl;
  const _ITADFiltersConfig._() : super._();

  factory _ITADFiltersConfig.fromJson(Map<String, dynamic> json) =
      _$ITADFiltersConfigImpl.fromJson;

  @override
  ITADFilters get cached;
  @override
  ITADFilters get current;

  /// Create a copy of ITADFiltersConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ITADFiltersConfigImplCopyWith<_$ITADFiltersConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
