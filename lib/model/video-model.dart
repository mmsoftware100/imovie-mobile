import 'package:imovie/model/season-model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:imovie/model/category-model.dart';
import 'package:imovie/model/episode-model.dart';
import 'package:imovie/model/file-model.dart';


/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'video-model.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
/// nested object
@JsonSerializable(explicitToJson: true)
class VideoModel{
  int id;
  String name;
  String description;
  String poster_portrait;
  String poster_landscape;
  int release_year;
  int movie_type;
  List<CategoryModel> category;
  List<SeasonModel> season_list;

  VideoModel(this.id, this.name, this.description, this.poster_portrait, this.poster_landscape, this.release_year, this.movie_type , this.category, this.season_list);


  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory VideoModel.fromJson(Map<String, dynamic> json) => _$VideoModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$VideoModelToJson(this);
}