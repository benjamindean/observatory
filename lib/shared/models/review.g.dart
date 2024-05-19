// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewImpl _$$ReviewImplFromJson(Map<String, dynamic> json) => _$ReviewImpl(
      score: (json['score'] as num?)?.toInt(),
      source: json['source'] as String?,
      count: json['count'] as num?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$$ReviewImplToJson(_$ReviewImpl instance) =>
    <String, dynamic>{
      'score': instance.score,
      'source': instance.source,
      'count': instance.count,
      'url': instance.url,
    };
