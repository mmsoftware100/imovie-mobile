// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EpisodeModel _$EpisodeModelFromJson(Map<String, dynamic> json) {
  return EpisodeModel(
    json['id'] as int,
    json['episode'] == null
        ? null
        : EpisodeObject.fromJson(json['episode'] as Map<String, dynamic>),
    json['duration'] as int,
    json['episode_description'] as String,
    (json['file_model_list'] as List)
        ?.map((e) =>
            e == null ? null : FileModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$EpisodeModelToJson(EpisodeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'episode': instance.episode?.toJson(),
      'duration': instance.duration,
      'episode_description': instance.episode_description,
      'file_model_list':
          instance.file_model_list?.map((e) => e?.toJson())?.toList(),
    };
