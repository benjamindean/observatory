// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BackupImpl _$$BackupImplFromJson(Map<String, dynamic> json) => _$BackupImpl(
      folder: json['folder'] as String?,
      waitlist: (json['waitlist'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      date: json['date'] as String?,
    );

Map<String, dynamic> _$$BackupImplToJson(_$BackupImpl instance) =>
    <String, dynamic>{
      'folder': instance.folder,
      'waitlist': instance.waitlist,
      'date': instance.date,
    };
