// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'season-object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeasonObject _$SeasonObjectFromJson(Map<String, dynamic> json) {
  return SeasonObject(
    json['id'] as int,
    json['name'] as String,
  );
}

Map<String, dynamic> _$SeasonObjectToJson(SeasonObject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
