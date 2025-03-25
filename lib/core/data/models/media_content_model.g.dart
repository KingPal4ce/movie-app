// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaContentModel _$MediaContentModelFromJson(Map<String, dynamic> json) => MediaContentModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String?,
  posterPath: json['poster_path'] as String?,
  voteAverage: (json['vote_average'] as num?)?.toDouble(),
  mediaType: json['media_type'] as String?,
);

Map<String, dynamic> _$MediaContentModelToJson(MediaContentModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'poster_path': instance.posterPath,
  'vote_average': instance.voteAverage,
  'media_type': instance.mediaType,
};
