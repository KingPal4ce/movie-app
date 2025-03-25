// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_content_reviews_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaContentReviewsModel _$MediaContentReviewsModelFromJson(Map<String, dynamic> json) =>
    MediaContentReviewsModel(results: (json['results'] as List<dynamic>).map((e) => Review.fromJson(e as Map<String, dynamic>)).toList());

Map<String, dynamic> _$MediaContentReviewsModelToJson(MediaContentReviewsModel instance) => <String, dynamic>{'results': instance.results};

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
  author: json['author'] as String,
  content: json['content'] as String,
  authorDetails: AuthorDetails.fromJson(json['authorDetails'] as Map<String, dynamic>),
  createdAt: json['created_at'] as String,
  url: json['url'] as String,
);

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
  'author': instance.author,
  'content': instance.content,
  'authorDetails': instance.authorDetails,
  'created_at': instance.createdAt,
  'url': instance.url,
};

AuthorDetails _$AuthorDetailsFromJson(Map<String, dynamic> json) => AuthorDetails(
  name: json['name'] as String?,
  username: json['username'] as String?,
  avatarPath: json['avatarPath'] as String?,
  rating: (json['rating'] as num?)?.toDouble(),
);

Map<String, dynamic> _$AuthorDetailsToJson(AuthorDetails instance) => <String, dynamic>{
  'name': instance.name,
  'username': instance.username,
  'avatarPath': instance.avatarPath,
  'rating': instance.rating,
};
