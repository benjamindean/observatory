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
  int? get min => throw _privateConstructorUsedError;
  @HiveField(1)
  int? get max => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MinMaxCopyWith<MinMax> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MinMaxCopyWith<$Res> {
  factory $MinMaxCopyWith(MinMax value, $Res Function(MinMax) then) =
      _$MinMaxCopyWithImpl<$Res, MinMax>;
  @useResult
  $Res call({@HiveField(0) int? min, @HiveField(1) int? max});
}

/// @nodoc
class _$MinMaxCopyWithImpl<$Res, $Val extends MinMax>
    implements $MinMaxCopyWith<$Res> {
  _$MinMaxCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? min = freezed,
    Object? max = freezed,
  }) {
    return _then(_value.copyWith(
      min: freezed == min
          ? _value.min
          : min // ignore: cast_nullable_to_non_nullable
              as int?,
      max: freezed == max
          ? _value.max
          : max // ignore: cast_nullable_to_non_nullable
              as int?,
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
  $Res call({@HiveField(0) int? min, @HiveField(1) int? max});
}

/// @nodoc
class __$$MinMaxImplCopyWithImpl<$Res>
    extends _$MinMaxCopyWithImpl<$Res, _$MinMaxImpl>
    implements _$$MinMaxImplCopyWith<$Res> {
  __$$MinMaxImplCopyWithImpl(
      _$MinMaxImpl _value, $Res Function(_$MinMaxImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? min = freezed,
    Object? max = freezed,
  }) {
    return _then(_$MinMaxImpl(
      min: freezed == min
          ? _value.min
          : min // ignore: cast_nullable_to_non_nullable
              as int?,
      max: freezed == max
          ? _value.max
          : max // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MinMaxImpl with DiagnosticableTreeMixin implements _MinMax {
  const _$MinMaxImpl({@HiveField(0) this.min, @HiveField(1) this.max});

  factory _$MinMaxImpl.fromJson(Map<String, dynamic> json) =>
      _$$MinMaxImplFromJson(json);

  @override
  @HiveField(0)
  final int? min;
  @override
  @HiveField(1)
  final int? max;

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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, min, max);

  @JsonKey(ignore: true)
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
      {@HiveField(0) final int? min,
      @HiveField(1) final int? max}) = _$MinMaxImpl;

  factory _MinMax.fromJson(Map<String, dynamic> json) = _$MinMaxImpl.fromJson;

  @override
  @HiveField(0)
  int? get min;
  @override
  @HiveField(1)
  int? get max;
  @override
  @JsonKey(ignore: true)
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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
      @HiveField(2) bool? bundled});

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

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? price = freezed,
    Object? cut = freezed,
    Object? bundled = freezed,
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
    ) as $Val);
  }

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
      @HiveField(2) bool? bundled});

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

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? price = freezed,
    Object? cut = freezed,
    Object? bundled = freezed,
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
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$ITADFiltersImpl extends _ITADFilters with DiagnosticableTreeMixin {
  const _$ITADFiltersImpl(
      {@HiveField(0) this.price,
      @HiveField(1) this.cut,
      @HiveField(2) this.bundled})
      : super._();

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

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ITADFilters(price: $price, cut: $cut, bundled: $bundled)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ITADFilters'))
      ..add(DiagnosticsProperty('price', price))
      ..add(DiagnosticsProperty('cut', cut))
      ..add(DiagnosticsProperty('bundled', bundled));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ITADFiltersImpl &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.cut, cut) || other.cut == cut) &&
            (identical(other.bundled, bundled) || other.bundled == bundled));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, price, cut, bundled);

  @JsonKey(ignore: true)
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
      @HiveField(2) final bool? bundled}) = _$ITADFiltersImpl;
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
  @JsonKey(ignore: true)
  _$$ITADFiltersImplCopyWith<_$ITADFiltersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
