// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'season-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeasonModel _$SeasonModelFromJson(Map<String, dynamic> json) {
  return SeasonModel(
    json['id'] as int,
    json['season'] == null
        ? null
        : SeasonObject.fromJson(json['season'] as Map<String, dynamic>),
    json['season_description'] as String,
    (json['episode_list'] as List)
        ?.map((e) =>
            e == null ? null : EpisodeModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SeasonModelToJson(SeasonModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'season': instance.season,
      'season_description': instance.season_description,
      'episode_list': instance.episode_list,
    };
