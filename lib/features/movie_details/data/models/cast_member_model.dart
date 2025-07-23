import 'package:json_annotation/json_annotation.dart';

part 'cast_member_model.g.dart';

@JsonSerializable()
class CastMemberModel {
  CastMemberModel({required this.name, this.character, this.profilePath});

  // convert json -> cast member
  factory CastMemberModel.fromJson(Map<String, dynamic> json) => _$CastMemberModelFromJson(json);
  final String? name;
  final String? character;
  @JsonKey(name: 'profile_path')
  final String? profilePath;

  // convert cast member -> json
  Map<String, dynamic> toJson() => _$CastMemberModelToJson(this);

  String? get fullProfilePath {
    if (profilePath == null) return null;
    return 'https://image.tmdb.org/t/p/w200$profilePath';
  }
}
