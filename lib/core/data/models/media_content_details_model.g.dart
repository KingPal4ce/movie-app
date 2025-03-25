// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_content_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaContentDetailsModel _$MediaContentDetailsModelFromJson(Map<String, dynamic> json) => MediaContentDetailsModel(
  backdropPath: json['backdrop_path'] as String?,
  title: json['title'] as String,
  voteAverage: (json['vote_average'] as num).toDouble(),
  overview: json['overview'] as String,
  releaseDate: json['release_date'] as String,
  runtime: (json['runtime'] as num).toInt(),
  budget: (json['budget'] as num).toInt(),
  revenue: (json['revenue'] as num).toInt(),
  genres: (json['genres'] as List<dynamic>).map((e) => Genre.fromJson(e as Map<String, dynamic>)).toList(),
);

Map<String, dynamic> _$MediaContentDetailsModelToJson(MediaContentDetailsModel instance) => <String, dynamic>{
  'backdrop_path': instance.backdropPath,
  'title': instance.title,
  'vote_average': instance.voteAverage,
  'overview': instance.overview,
  'release_date': instance.releaseDate,
  'runtime': instance.runtime,
  'budget': instance.budget,
  'revenue': instance.revenue,
  'genres': instance.genres,
};

Genre _$GenreFromJson(Map<String, dynamic> json) => Genre(name: json['name'] as String);

Map<String, dynamic> _$GenreToJson(Genre instance) => <String, dynamic>{'name': instance.name};
