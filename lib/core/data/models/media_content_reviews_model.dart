import 'package:json_annotation/json_annotation.dart';

part 'media_content_reviews_model.g.dart';

@JsonSerializable()
class MediaContentReviewsModel {
  factory MediaContentReviewsModel.fromJson(Map<String, dynamic> json) => _$MediaContentReviewsModelFromJson(json);
  MediaContentReviewsModel({required this.results});
  final List<Review> results;
  Map<String, dynamic> toJson() => _$MediaContentReviewsModelToJson(this);
}

@JsonSerializable()
class Review {
  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Review({required this.author, required this.content, required this.authorDetails, required this.createdAt, required this.url});
  final String author;
  final String content;
  final AuthorDetails authorDetails;
  @JsonKey(name: 'created_at')
  final String createdAt;
  final String url;
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}

@JsonSerializable()
class AuthorDetails {
  factory AuthorDetails.fromJson(Map<String, dynamic> json) => _$AuthorDetailsFromJson(json);
  AuthorDetails({this.name, this.username, this.avatarPath, this.rating});
  final String? name;
  final String? username;
  final String? avatarPath;
  final double? rating;
  Map<String, dynamic> toJson() => _$AuthorDetailsToJson(this);

  String get displayAvatar =>
      avatarPath == null
          ? "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png"
          : "https://image.tmdb.org/t/p/w500$avatarPath";

  String get displayRating => rating == null ? "Not Rated" : rating.toString();
}
