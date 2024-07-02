// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Deal _$DealFromJson(Map<String, dynamic> json) {
  return _Deal.fromJson(json);
}

/// @nodoc
mixin _$Deal {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get slug => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  @HiveField(2)
  String get title => throw _privateConstructorUsedError;
  String? get steamId => throw _privateConstructorUsedError;
  Info? get info => throw _privateConstructorUsedError;
  Overview? get overview => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  @HiveField(3)
  int get added => throw _privateConstructorUsedError;
  @HiveField(4)
  DealSource get source => throw _privateConstructorUsedError;
  @HiveField(5)
  List<Price>? get prices => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DealCopyWith<Deal> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DealCopyWith<$Res> {
  factory $DealCopyWith(Deal value, $Res Function(Deal) then) =
      _$DealCopyWithImpl<$Res, Deal>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String slug,
      String type,
      @HiveField(2) String title,
      String? steamId,
      Info? info,
      Overview? overview,
      bool isLoading,
      @HiveField(3) int added,
      @HiveField(4) DealSource source,
      @HiveField(5) List<Price>? prices});

  $InfoCopyWith<$Res>? get info;
  $OverviewCopyWith<$Res>? get overview;
}

/// @nodoc
class _$DealCopyWithImpl<$Res, $Val extends Deal>
    implements $DealCopyWith<$Res> {
  _$DealCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? slug = null,
    Object? type = null,
    Object? title = null,
    Object? steamId = freezed,
    Object? info = freezed,
    Object? overview = freezed,
    Object? isLoading = null,
    Object? added = null,
    Object? source = null,
    Object? prices = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      slug: null == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      steamId: freezed == steamId
          ? _value.steamId
          : steamId // ignore: cast_nullable_to_non_nullable
              as String?,
      info: freezed == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as Info?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as Overview?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      added: null == added
          ? _value.added
          : added // ignore: cast_nullable_to_non_nullable
              as int,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as DealSource,
      prices: freezed == prices
          ? _value.prices
          : prices // ignore: cast_nullable_to_non_nullable
              as List<Price>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $InfoCopyWith<$Res>? get info {
    if (_value.info == null) {
      return null;
    }

    return $InfoCopyWith<$Res>(_value.info!, (value) {
      return _then(_value.copyWith(info: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $OverviewCopyWith<$Res>? get overview {
    if (_value.overview == null) {
      return null;
    }

    return $OverviewCopyWith<$Res>(_value.overview!, (value) {
      return _then(_value.copyWith(overview: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DealImplCopyWith<$Res> implements $DealCopyWith<$Res> {
  factory _$$DealImplCopyWith(
          _$DealImpl value, $Res Function(_$DealImpl) then) =
      __$$DealImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String slug,
      String type,
      @HiveField(2) String title,
      String? steamId,
      Info? info,
      Overview? overview,
      bool isLoading,
      @HiveField(3) int added,
      @HiveField(4) DealSource source,
      @HiveField(5) List<Price>? prices});

  @override
  $InfoCopyWith<$Res>? get info;
  @override
  $OverviewCopyWith<$Res>? get overview;
}

/// @nodoc
class __$$DealImplCopyWithImpl<$Res>
    extends _$DealCopyWithImpl<$Res, _$DealImpl>
    implements _$$DealImplCopyWith<$Res> {
  __$$DealImplCopyWithImpl(_$DealImpl _value, $Res Function(_$DealImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? slug = null,
    Object? type = null,
    Object? title = null,
    Object? steamId = freezed,
    Object? info = freezed,
    Object? overview = freezed,
    Object? isLoading = null,
    Object? added = null,
    Object? source = null,
    Object? prices = freezed,
  }) {
    return _then(_$DealImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      slug: null == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      steamId: freezed == steamId
          ? _value.steamId
          : steamId // ignore: cast_nullable_to_non_nullable
              as String?,
      info: freezed == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as Info?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as Overview?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      added: null == added
          ? _value.added
          : added // ignore: cast_nullable_to_non_nullable
              as int,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as DealSource,
      prices: freezed == prices
          ? _value._prices
          : prices // ignore: cast_nullable_to_non_nullable
              as List<Price>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DealImpl extends _Deal {
  const _$DealImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) this.slug = '',
      this.type = 'game',
      @HiveField(2) this.title = '',
      this.steamId,
      this.info,
      this.overview,
      this.isLoading = false,
      @HiveField(3) this.added = 0,
      @HiveField(4) this.source = DealSource.itad,
      @HiveField(5) final List<Price>? prices})
      : _prices = prices,
        super._();

  factory _$DealImpl.fromJson(Map<String, dynamic> json) =>
      _$$DealImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @JsonKey()
  @HiveField(1)
  final String slug;
  @override
  @JsonKey()
  final String type;
  @override
  @JsonKey()
  @HiveField(2)
  final String title;
  @override
  final String? steamId;
  @override
  final Info? info;
  @override
  final Overview? overview;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  @HiveField(3)
  final int added;
  @override
  @JsonKey()
  @HiveField(4)
  final DealSource source;
  final List<Price>? _prices;
  @override
  @HiveField(5)
  List<Price>? get prices {
    final value = _prices;
    if (value == null) return null;
    if (_prices is EqualUnmodifiableListView) return _prices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Deal(id: $id, slug: $slug, type: $type, title: $title, steamId: $steamId, info: $info, overview: $overview, isLoading: $isLoading, added: $added, source: $source, prices: $prices)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DealImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.steamId, steamId) || other.steamId == steamId) &&
            (identical(other.info, info) || other.info == info) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.added, added) || other.added == added) &&
            (identical(other.source, source) || other.source == source) &&
            const DeepCollectionEquality().equals(other._prices, _prices));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      slug,
      type,
      title,
      steamId,
      info,
      overview,
      isLoading,
      added,
      source,
      const DeepCollectionEquality().hash(_prices));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DealImplCopyWith<_$DealImpl> get copyWith =>
      __$$DealImplCopyWithImpl<_$DealImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DealImplToJson(
      this,
    );
  }
}

abstract class _Deal extends Deal {
  const factory _Deal(
      {@HiveField(0) required final String id,
      @HiveField(1) final String slug,
      final String type,
      @HiveField(2) final String title,
      final String? steamId,
      final Info? info,
      final Overview? overview,
      final bool isLoading,
      @HiveField(3) final int added,
      @HiveField(4) final DealSource source,
      @HiveField(5) final List<Price>? prices}) = _$DealImpl;
  const _Deal._() : super._();

  factory _Deal.fromJson(Map<String, dynamic> json) = _$DealImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get slug;
  @override
  String get type;
  @override
  @HiveField(2)
  String get title;
  @override
  String? get steamId;
  @override
  Info? get info;
  @override
  Overview? get overview;
  @override
  bool get isLoading;
  @override
  @HiveField(3)
  int get added;
  @override
  @HiveField(4)
  DealSource get source;
  @override
  @HiveField(5)
  List<Price>? get prices;
  @override
  @JsonKey(ignore: true)
  _$$DealImplCopyWith<_$DealImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
