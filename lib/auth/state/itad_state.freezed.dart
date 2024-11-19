// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'itad_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ITADUser _$ITADUserFromJson(Map<String, dynamic> json) {
  return _ITADUser.fromJson(json);
}

/// @nodoc
mixin _$ITADUser {
  @HiveField(0)
  String? get username => throw _privateConstructorUsedError;
  @HiveField(1)
  String? get credentials => throw _privateConstructorUsedError;

  /// Serializes this ITADUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ITADUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ITADUserCopyWith<ITADUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ITADUserCopyWith<$Res> {
  factory $ITADUserCopyWith(ITADUser value, $Res Function(ITADUser) then) =
      _$ITADUserCopyWithImpl<$Res, ITADUser>;
  @useResult
  $Res call(
      {@HiveField(0) String? username, @HiveField(1) String? credentials});
}

/// @nodoc
class _$ITADUserCopyWithImpl<$Res, $Val extends ITADUser>
    implements $ITADUserCopyWith<$Res> {
  _$ITADUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ITADUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = freezed,
    Object? credentials = freezed,
  }) {
    return _then(_value.copyWith(
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      credentials: freezed == credentials
          ? _value.credentials
          : credentials // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ITADUserImplCopyWith<$Res>
    implements $ITADUserCopyWith<$Res> {
  factory _$$ITADUserImplCopyWith(
          _$ITADUserImpl value, $Res Function(_$ITADUserImpl) then) =
      __$$ITADUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String? username, @HiveField(1) String? credentials});
}

/// @nodoc
class __$$ITADUserImplCopyWithImpl<$Res>
    extends _$ITADUserCopyWithImpl<$Res, _$ITADUserImpl>
    implements _$$ITADUserImplCopyWith<$Res> {
  __$$ITADUserImplCopyWithImpl(
      _$ITADUserImpl _value, $Res Function(_$ITADUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of ITADUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = freezed,
    Object? credentials = freezed,
  }) {
    return _then(_$ITADUserImpl(
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      credentials: freezed == credentials
          ? _value.credentials
          : credentials // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ITADUserImpl implements _ITADUser {
  const _$ITADUserImpl(
      {@HiveField(0) this.username, @HiveField(1) this.credentials});

  factory _$ITADUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$ITADUserImplFromJson(json);

  @override
  @HiveField(0)
  final String? username;
  @override
  @HiveField(1)
  final String? credentials;

  @override
  String toString() {
    return 'ITADUser(username: $username, credentials: $credentials)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ITADUserImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.credentials, credentials) ||
                other.credentials == credentials));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, username, credentials);

  /// Create a copy of ITADUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ITADUserImplCopyWith<_$ITADUserImpl> get copyWith =>
      __$$ITADUserImplCopyWithImpl<_$ITADUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ITADUserImplToJson(
      this,
    );
  }
}

abstract class _ITADUser implements ITADUser {
  const factory _ITADUser(
      {@HiveField(0) final String? username,
      @HiveField(1) final String? credentials}) = _$ITADUserImpl;

  factory _ITADUser.fromJson(Map<String, dynamic> json) =
      _$ITADUserImpl.fromJson;

  @override
  @HiveField(0)
  String? get username;
  @override
  @HiveField(1)
  String? get credentials;

  /// Create a copy of ITADUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ITADUserImplCopyWith<_$ITADUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ITADState {
  ITADUser? get user => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  Client? get client => throw _privateConstructorUsedError;
  String? get lastSyncDate => throw _privateConstructorUsedError;
  AuthorizationCodeGrant? get grant => throw _privateConstructorUsedError;
  Uri? get autorizationUrl => throw _privateConstructorUsedError;

  /// Create a copy of ITADState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ITADStateCopyWith<ITADState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ITADStateCopyWith<$Res> {
  factory $ITADStateCopyWith(ITADState value, $Res Function(ITADState) then) =
      _$ITADStateCopyWithImpl<$Res, ITADState>;
  @useResult
  $Res call(
      {ITADUser? user,
      bool isLoading,
      String? error,
      Client? client,
      String? lastSyncDate,
      AuthorizationCodeGrant? grant,
      Uri? autorizationUrl});

  $ITADUserCopyWith<$Res>? get user;
}

/// @nodoc
class _$ITADStateCopyWithImpl<$Res, $Val extends ITADState>
    implements $ITADStateCopyWith<$Res> {
  _$ITADStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ITADState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? isLoading = null,
    Object? error = freezed,
    Object? client = freezed,
    Object? lastSyncDate = freezed,
    Object? grant = freezed,
    Object? autorizationUrl = freezed,
  }) {
    return _then(_value.copyWith(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as ITADUser?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      client: freezed == client
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as Client?,
      lastSyncDate: freezed == lastSyncDate
          ? _value.lastSyncDate
          : lastSyncDate // ignore: cast_nullable_to_non_nullable
              as String?,
      grant: freezed == grant
          ? _value.grant
          : grant // ignore: cast_nullable_to_non_nullable
              as AuthorizationCodeGrant?,
      autorizationUrl: freezed == autorizationUrl
          ? _value.autorizationUrl
          : autorizationUrl // ignore: cast_nullable_to_non_nullable
              as Uri?,
    ) as $Val);
  }

  /// Create a copy of ITADState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ITADUserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $ITADUserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ITADStateImplCopyWith<$Res>
    implements $ITADStateCopyWith<$Res> {
  factory _$$ITADStateImplCopyWith(
          _$ITADStateImpl value, $Res Function(_$ITADStateImpl) then) =
      __$$ITADStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ITADUser? user,
      bool isLoading,
      String? error,
      Client? client,
      String? lastSyncDate,
      AuthorizationCodeGrant? grant,
      Uri? autorizationUrl});

  @override
  $ITADUserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$ITADStateImplCopyWithImpl<$Res>
    extends _$ITADStateCopyWithImpl<$Res, _$ITADStateImpl>
    implements _$$ITADStateImplCopyWith<$Res> {
  __$$ITADStateImplCopyWithImpl(
      _$ITADStateImpl _value, $Res Function(_$ITADStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ITADState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? isLoading = null,
    Object? error = freezed,
    Object? client = freezed,
    Object? lastSyncDate = freezed,
    Object? grant = freezed,
    Object? autorizationUrl = freezed,
  }) {
    return _then(_$ITADStateImpl(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as ITADUser?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      client: freezed == client
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as Client?,
      lastSyncDate: freezed == lastSyncDate
          ? _value.lastSyncDate
          : lastSyncDate // ignore: cast_nullable_to_non_nullable
              as String?,
      grant: freezed == grant
          ? _value.grant
          : grant // ignore: cast_nullable_to_non_nullable
              as AuthorizationCodeGrant?,
      autorizationUrl: freezed == autorizationUrl
          ? _value.autorizationUrl
          : autorizationUrl // ignore: cast_nullable_to_non_nullable
              as Uri?,
    ));
  }
}

/// @nodoc

class _$ITADStateImpl implements _ITADState {
  const _$ITADStateImpl(
      {this.user,
      this.isLoading = false,
      this.error,
      this.client,
      this.lastSyncDate,
      this.grant,
      this.autorizationUrl});

  @override
  final ITADUser? user;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;
  @override
  final Client? client;
  @override
  final String? lastSyncDate;
  @override
  final AuthorizationCodeGrant? grant;
  @override
  final Uri? autorizationUrl;

  @override
  String toString() {
    return 'ITADState(user: $user, isLoading: $isLoading, error: $error, client: $client, lastSyncDate: $lastSyncDate, grant: $grant, autorizationUrl: $autorizationUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ITADStateImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.client, client) || other.client == client) &&
            (identical(other.lastSyncDate, lastSyncDate) ||
                other.lastSyncDate == lastSyncDate) &&
            (identical(other.grant, grant) || other.grant == grant) &&
            (identical(other.autorizationUrl, autorizationUrl) ||
                other.autorizationUrl == autorizationUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user, isLoading, error, client,
      lastSyncDate, grant, autorizationUrl);

  /// Create a copy of ITADState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ITADStateImplCopyWith<_$ITADStateImpl> get copyWith =>
      __$$ITADStateImplCopyWithImpl<_$ITADStateImpl>(this, _$identity);
}

abstract class _ITADState implements ITADState {
  const factory _ITADState(
      {final ITADUser? user,
      final bool isLoading,
      final String? error,
      final Client? client,
      final String? lastSyncDate,
      final AuthorizationCodeGrant? grant,
      final Uri? autorizationUrl}) = _$ITADStateImpl;

  @override
  ITADUser? get user;
  @override
  bool get isLoading;
  @override
  String? get error;
  @override
  Client? get client;
  @override
  String? get lastSyncDate;
  @override
  AuthorizationCodeGrant? get grant;
  @override
  Uri? get autorizationUrl;

  /// Create a copy of ITADState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ITADStateImplCopyWith<_$ITADStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
