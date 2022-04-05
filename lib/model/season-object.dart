import 'package:json_annotation/json_annotation.dart';
part 'season-object.g.dart';
@JsonSerializable()
class SeasonObject{
  int id;
  String name;

  SeasonObject(this.id,this.name,);
  factory SeasonObject.fromJson(Map<String, dynamic> json) => _$SeasonObjectFromJson(json);
  Map<String, dynamic> toJson() => _$SeasonObjectToJson(this);
}