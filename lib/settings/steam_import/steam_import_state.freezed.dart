// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'steam_import_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SteamUser _$SteamUserFromJson(Map<String, dynamic> json) {
  return _SteamUser.fromJson(json);
}

/// @nodoc
mixin _$SteamUser {
  @HiveField(0)
  String? get steamid => throw _privateConstructorUsedError;
  @HiveField(1)
  String? get personaname => throw _privateConstructorUsedError;
  @HiveField(2)
  String? get profileurl => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get avatar => throw _privateConstructorUsedError;

  /// Serializes this SteamUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SteamUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SteamUserCopyWith<SteamUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SteamUserCopyWith<$Res> {
  factory $SteamUserCopyWith(SteamUser value, $Res Function(SteamUser) then) =
      _$SteamUserCopyWithImpl<$Res, SteamUser>;
  @useResult
  $Res call(
      {@HiveField(0) String? steamid,
      @HiveField(1) String? personaname,
      @HiveField(2) String? profileurl,
      @HiveField(3) String? avatar});
}

/// @nodoc
class _$SteamUserCopyWithImpl<$Res, $Val extends SteamUser>
    implements $SteamUserCopyWith<$Res> {
  _$SteamUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SteamUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? steamid = freezed,
    Object? personaname = freezed,
    Object? profileurl = freezed,
    Object? avatar = freezed,
  }) {
    return _then(_value.copyWith(
      steamid: freezed == steamid
          ? _value.steamid
          : steamid // ignore: cast_nullable_to_non_nullable
              as String?,
      personaname: freezed == personaname
          ? _value.personaname
          : personaname // ignore: cast_nullable_to_non_nullable
              as String?,
      profileurl: freezed == profileurl
          ? _value.profileurl
          : profileurl // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SteamUserImplCopyWith<$Res>
    implements $SteamUserCopyWith<$Res> {
  factory _$$SteamUserImplCopyWith(
          _$SteamUserImpl value, $Res Function(_$SteamUserImpl) then) =
      __$$SteamUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String? steamid,
      @HiveField(1) String? personaname,
      @HiveField(2) String? profileurl,
      @HiveField(3) String? avatar});
}

/// @nodoc
class __$$SteamUserImplCopyWithImpl<$Res>
    extends _$SteamUserCopyWithImpl<$Res, _$SteamUserImpl>
    implements _$$SteamUserImplCopyWith<$Res> {
  __$$SteamUserImplCopyWithImpl(
      _$SteamUserImpl _value, $Res Function(_$SteamUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of SteamUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? steamid = freezed,
    Object? personaname = freezed,
    Object? profileurl = freezed,
    Object? avatar = freezed,
  }) {
    return _then(_$SteamUserImpl(
      steamid: freezed == steamid
          ? _value.steamid
          : steamid // ignore: cast_nullable_to_non_nullable
              as String?,
      personaname: freezed == personaname
          ? _value.personaname
          : personaname // ignore: cast_nullable_to_non_nullable
              as String?,
      profileurl: freezed == profileurl
          ? _value.profileurl
          : profileurl // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SteamUserImpl implements _SteamUser {
  const _$SteamUserImpl(
      {@HiveField(0) this.steamid,
      @HiveField(1) this.personaname,
      @HiveField(2) this.profileurl,
      @HiveField(3) this.avatar});

  factory _$SteamUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$SteamUserImplFromJson(json);

  @override
  @HiveField(0)
  final String? steamid;
  @override
  @HiveField(1)
  final String? personaname;
  @override
  @HiveField(2)
  final String? profileurl;
  @override
  @HiveField(3)
  final String? avatar;

  @override
  String toString() {
    return 'SteamUser(steamid: $steamid, personaname: $personaname, profileurl: $profileurl, avatar: $avatar)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SteamUserImpl &&
            (identical(other.steamid, steamid) || other.steamid == steamid) &&
            (identical(other.personaname, personaname) ||
                other.personaname == personaname) &&
            (identical(other.profileurl, profileurl) ||
                other.profileurl == profileurl) &&
            (identical(other.avatar, avatar) || other.avatar == avatar));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, steamid, personaname, profileurl, avatar);

  /// Create a copy of SteamUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SteamUserImplCopyWith<_$SteamUserImpl> get copyWith =>
      __$$SteamUserImplCopyWithImpl<_$SteamUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SteamUserImplToJson(
      this,
    );
  }
}

abstract class _SteamUser implements SteamUser {
  const factory _SteamUser(
      {@HiveField(0) final String? steamid,
      @HiveField(1) final String? personaname,
      @HiveField(2) final String? profileurl,
      @HiveField(3) final String? avatar}) = _$SteamUserImpl;

  factory _SteamUser.fromJson(Map<String, dynamic> json) =
      _$SteamUserImpl.fromJson;

  @override
  @HiveField(0)
  String? get steamid;
  @override
  @HiveField(1)
  String? get personaname;
  @override
  @HiveField(2)
  String? get profileurl;
  @override
  @HiveField(3)
  String? get avatar;

  /// Create a copy of SteamUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SteamUserImplCopyWith<_$SteamUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SteamImportState {
  SteamUser? get steamUser => throw _privateConstructorUsedError;
  List<Deal>? get deals => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of SteamImportState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SteamImportStateCopyWith<SteamImportState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SteamImportStateCopyWith<$Res> {
  factory $SteamImportStateCopyWith(
          SteamImportState value, $Res Function(SteamImportState) then) =
      _$SteamImportStateCopyWithImpl<$Res, SteamImportState>;
  @useResult
  $Res call(
      {SteamUser? steamUser, List<Deal>? deals, bool isLoading, String? error});

  $SteamUserCopyWith<$Res>? get steamUser;
}

/// @nodoc
class _$SteamImportStateCopyWithImpl<$Res, $Val extends SteamImportState>
    implements $SteamImportStateCopyWith<$Res> {
  _$SteamImportStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SteamImportState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? steamUser = freezed,
    Object? deals = freezed,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      steamUser: freezed == steamUser
          ? _value.steamUser
          : steamUser // ignore: cast_nullable_to_non_nullable
              as SteamUser?,
      deals: freezed == deals
          ? _value.deals
          : deals // ignore: cast_nullable_to_non_nullable
              as List<Deal>?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of SteamImportState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SteamUserCopyWith<$Res>? get steamUser {
    if (_value.steamUser == null) {
      return null;
    }

    return $SteamUserCopyWith<$Res>(_value.steamUser!, (value) {
      return _then(_value.copyWith(steamUser: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SteamImportStateImplCopyWith<$Res>
    implements $SteamImportStateCopyWith<$Res> {
  factory _$$SteamImportStateImplCopyWith(_$SteamImportStateImpl value,
          $Res Function(_$SteamImportStateImpl) then) =
      __$$SteamImportStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {SteamUser? steamUser, List<Deal>? deals, bool isLoading, String? error});

  @override
  $SteamUserCopyWith<$Res>? get steamUser;
}

/// @nodoc
class __$$SteamImportStateImplCopyWithImpl<$Res>
    extends _$SteamImportStateCopyWithImpl<$Res, _$SteamImportStateImpl>
    implements _$$SteamImportStateImplCopyWith<$Res> {
  __$$SteamImportStateImplCopyWithImpl(_$SteamImportStateImpl _value,
      $Res Function(_$SteamImportStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SteamImportState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? steamUser = freezed,
    Object? deals = freezed,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_$SteamImportStateImpl(
      steamUser: freezed == steamUser
          ? _value.steamUser
          : steamUser // ignore: cast_nullable_to_non_nullable
              as SteamUser?,
      deals: freezed == deals
          ? _value._deals
          : deals // ignore: cast_nullable_to_non_nullable
              as List<Deal>?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SteamImportStateImpl implements _SteamImportState {
  const _$SteamImportStateImpl(
      {this.steamUser,
      final List<Deal>? deals,
      this.isLoading = false,
      this.error})
      : _deals = deals;

  @override
  final SteamUser? steamUser;
  final List<Deal>? _deals;
  @override
  List<Deal>? get deals {
    final value = _deals;
    if (value == null) return null;
    if (_deals is EqualUnmodifiableListView) return _deals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;

  @override
  String toString() {
    return 'SteamImportState(steamUser: $steamUser, deals: $deals, isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SteamImportStateImpl &&
            (identical(other.steamUser, steamUser) ||
                other.steamUser == steamUser) &&
            const DeepCollectionEquality().equals(other._deals, _deals) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, steamUser,
      const DeepCollectionEquality().hash(_deals), isLoading, error);

  /// Create a copy of SteamImportState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SteamImportStateImplCopyWith<_$SteamImportStateImpl> get copyWith =>
      __$$SteamImportStateImplCopyWithImpl<_$SteamImportStateImpl>(
          this, _$identity);
}

abstract class _SteamImportState implements SteamImportState {
  const factory _SteamImportState(
      {final SteamUser? steamUser,
      final List<Deal>? deals,
      final bool isLoading,
      final String? error}) = _$SteamImportStateImpl;

  @override
  SteamUser? get steamUser;
  @override
  List<Deal>? get deals;
  @override
  bool get isLoading;
  @override
  String? get error;

  /// Create a copy of SteamImportState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SteamImportStateImplCopyWith<_$SteamImportStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
