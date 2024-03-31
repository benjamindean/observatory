// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChartEntryImpl _$$ChartEntryImplFromJson(Map<String, dynamic> json) =>
    _$ChartEntryImpl(
      title: json['title'] as String,
      id: json['id'] as String,
      position: (json['position'] as num).toDouble(),
    );

Map<String, dynamic> _$$ChartEntryImplToJson(_$ChartEntryImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'id': instance.id,
      'position': instance.position,
    };
