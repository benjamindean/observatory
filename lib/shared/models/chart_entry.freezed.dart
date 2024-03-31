// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chart_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChartEntry _$ChartEntryFromJson(Map<String, dynamic> json) {
  return _ChartEntry.fromJson(json);
}

/// @nodoc
mixin _$ChartEntry {
  String get title => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  double get position => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChartEntryCopyWith<ChartEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChartEntryCopyWith<$Res> {
  factory $ChartEntryCopyWith(
          ChartEntry value, $Res Function(ChartEntry) then) =
      _$ChartEntryCopyWithImpl<$Res, ChartEntry>;
  @useResult
  $Res call({String title, String id, double position});
}

/// @nodoc
class _$ChartEntryCopyWithImpl<$Res, $Val extends ChartEntry>
    implements $ChartEntryCopyWith<$Res> {
  _$ChartEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? id = null,
    Object? position = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChartEntryImplCopyWith<$Res>
    implements $ChartEntryCopyWith<$Res> {
  factory _$$ChartEntryImplCopyWith(
          _$ChartEntryImpl value, $Res Function(_$ChartEntryImpl) then) =
      __$$ChartEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String id, double position});
}

/// @nodoc
class __$$ChartEntryImplCopyWithImpl<$Res>
    extends _$ChartEntryCopyWithImpl<$Res, _$ChartEntryImpl>
    implements _$$ChartEntryImplCopyWith<$Res> {
  __$$ChartEntryImplCopyWithImpl(
      _$ChartEntryImpl _value, $Res Function(_$ChartEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? id = null,
    Object? position = null,
  }) {
    return _then(_$ChartEntryImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChartEntryImpl implements _ChartEntry {
  const _$ChartEntryImpl(
      {required this.title, required this.id, required this.position});

  factory _$ChartEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChartEntryImplFromJson(json);

  @override
  final String title;
  @override
  final String id;
  @override
  final double position;

  @override
  String toString() {
    return 'ChartEntry(title: $title, id: $id, position: $position)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChartEntryImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, id, position);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChartEntryImplCopyWith<_$ChartEntryImpl> get copyWith =>
      __$$ChartEntryImplCopyWithImpl<_$ChartEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChartEntryImplToJson(
      this,
    );
  }
}

abstract class _ChartEntry implements ChartEntry {
  const factory _ChartEntry(
      {required final String title,
      required final String id,
      required final double position}) = _$ChartEntryImpl;

  factory _ChartEntry.fromJson(Map<String, dynamic> json) =
      _$ChartEntryImpl.fromJson;

  @override
  String get title;
  @override
  String get id;
  @override
  double get position;
  @override
  @JsonKey(ignore: true)
  _$$ChartEntryImplCopyWith<_$ChartEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
