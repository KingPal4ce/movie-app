import 'package:json_annotation/json_annotation.dart';

part 'trailers_model.g.dart';

@JsonSerializable()
class TrailersModel {
  TrailersModel({required this.key, required this.site, required this.type});

  factory TrailersModel.fromJson(Map<String, dynamic> json) => _$TrailersModelFromJson(json);
  final String key;
  final String site;
  final String type;

  Map<String, dynamic> toJson() => _$TrailersModelToJson(this);

  String get videoUrl => site == 'YouTube' ? 'https://www.youtube.com/watch?v=$key' : '';
}
