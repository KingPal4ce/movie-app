// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_content_search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaContentSearchModel _$MediaContentSearchModelFromJson(Map<String, dynamic> json) => MediaContentSearchModel(
  id: (json['id'] as num).toInt(),
  posterPath: json['poster_path'] as String?,
  voteAverage: (json['vote_average'] as num).toDouble(),
  popularity: (json['popularity'] as num?)?.toDouble(),
  overview: json['overview'] as String?,
);

Map<String, dynamic> _$MediaContentSearchModelToJson(MediaContentSearchModel instance) => <String, dynamic>{
  'id': instance.id,
  'poster_path': instance.posterPath,
  'vote_average': instance.voteAverage,
  'popularity': instance.popularity,
  'overview': instance.overview,
};
