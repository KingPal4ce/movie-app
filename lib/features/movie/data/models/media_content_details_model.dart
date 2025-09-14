import 'package:json_annotation/json_annotation.dart';

part 'media_content_details_model.g.dart';

@JsonSerializable()
class MediaContentDetailsModel {
  factory MediaContentDetailsModel.fromJson(Map<String, dynamic> json) => _$MediaContentDetailsModelFromJson(json);
  MediaContentDetailsModel({
    required this.backdropPath,
    required this.title,
    required this.voteAverage,
    required this.overview,
    required this.releaseDate,
    required this.runtime,
    required this.budget,
    required this.revenue,
    required this.genres,
  });
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  final String title;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  final String overview;
  @JsonKey(name: 'release_date')
  final String releaseDate;
  final int runtime;
  final int budget;
  final int revenue;
  final List<Genre> genres;

  Map<String, dynamic> toJson() => _$MediaContentDetailsModelToJson(this);

  List<String> get genreNames => genres.map((Genre g) => g.name).toList();
}

@JsonSerializable()
class Genre {
  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
  Genre({required this.name});
  final String name;

  Map<String, dynamic> toJson() => _$GenreToJson(this);
}
