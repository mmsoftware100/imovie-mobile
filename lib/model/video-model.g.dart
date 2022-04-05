// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoModel _$VideoModelFromJson(Map<String, dynamic> json) {
  return VideoModel(
    json['id'] as int,
    json['name'] as String,
    json['description'] as String,
    json['poster_portrait'] as String,
    json['poster_landscape'] as String,
    json['release_year'] as int,
    json['movie_type'] as int,
    (json['category'] as List)
        ?.map((e) => e == null
            ? null
            : CategoryModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['season_list'] as List)
        ?.map((e) =>
            e == null ? null : SeasonModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$VideoModelToJson(VideoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'poster_portrait': instance.poster_portrait,
      'poster_landscape': instance.poster_landscape,
      'release_year': instance.release_year,
      'movie_type': instance.movie_type,
      'category': instance.category?.map((e) => e?.toJson())?.toList(),
      'season_list': instance.season_list?.map((e) => e?.toJson())?.toList(),
    };
