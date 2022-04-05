import 'package:json_annotation/json_annotation.dart';
import 'package:imovie/model/resolution-model.dart';


/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'file-model.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
/// nested object
@JsonSerializable(explicitToJson: true)
class FileModel{
  int id;
  ResolutionModel resolution;
  String name;
  int file_size;

  FileModel(this.id, this.resolution, this.name, this.file_size);



  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory FileModel.fromJson(Map<String, dynamic> json) => _$FileModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$FileModelToJson(this);
}