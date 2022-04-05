import 'package:json_annotation/json_annotation.dart';
part 'episode-object.g.dart';
@JsonSerializable()
class EpisodeObject{
  int id;
  String name;

  EpisodeObject(this.id,this.name,);
  factory EpisodeObject.fromJson(Map<String, dynamic> json) => _$EpisodeObjectFromJson(json);
  Map<String, dynamic> toJson() => _$EpisodeObjectToJson(this);
}