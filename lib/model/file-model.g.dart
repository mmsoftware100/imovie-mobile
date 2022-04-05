// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileModel _$FileModelFromJson(Map<String, dynamic> json) {
  return FileModel(
    json['id'] as int,
    json['resolution'] == null
        ? null
        : ResolutionModel.fromJson(json['resolution'] as Map<String, dynamic>),
    json['name'] as String,
    json['file_size'] as int,
  );
}

Map<String, dynamic> _$FileModelToJson(FileModel instance) => <String, dynamic>{
      'id': instance.id,
      'resolution': instance.resolution?.toJson(),
      'name': instance.name,
      'file_size': instance.file_size,
    };
