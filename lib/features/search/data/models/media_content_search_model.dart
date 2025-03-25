import 'package:json_annotation/json_annotation.dart';

part 'media_content_search_model.g.dart';

@JsonSerializable()
class MediaContentSearchModel {
  factory MediaContentSearchModel.fromJson(Map<String, dynamic> json) => _$MediaContentSearchModelFromJson(json);
  MediaContentSearchModel({required this.id, this.posterPath, required this.voteAverage, this.popularity, this.overview});

  final int id;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  final double? popularity;
  final String? overview;

  Map<String, dynamic> toJson() => _$MediaContentSearchModelToJson(this);

  String? get fullPosterPath {
    if (posterPath == null) return null;
    return 'https://image.tmdb.org/t/p/w500$posterPath';
  }
}
