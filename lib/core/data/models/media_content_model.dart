import 'package:json_annotation/json_annotation.dart';

part 'media_content_model.g.dart';

@JsonSerializable()
class MediaContentModel {
  MediaContentModel({required this.id, this.name, this.posterPath, this.voteAverage, this.mediaType});

  // convert json -> media content
  factory MediaContentModel.fromJson(Map<String, dynamic> json) => _$MediaContentModelFromJson(json);
  final int id;
  final String? name;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'vote_average')
  final double? voteAverage;
  @JsonKey(name: 'media_type')
  final String? mediaType;

  // convert media content -> json
  Map<String, dynamic> toJson() => _$MediaContentModelToJson(this);
}
