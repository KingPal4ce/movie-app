import 'package:json_annotation/json_annotation.dart';

part 'app_user.g.dart';

@JsonSerializable()
class AppUser {
  AppUser({required this.uid, required this.email, required this.name});

  // convert json -> app user
  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
  final String uid;
  final String email;
  final String name;

  // convert app user -> json
  Map<String, dynamic> toJson() => _$AppUserToJson(this);
}
