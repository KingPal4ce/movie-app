import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_app/features/auth/data/models/app_user.dart';

part 'auth_states.freezed.dart';

@freezed
abstract class AuthStates with _$AuthStates {
  const factory AuthStates.initial() = Initial;
  const factory AuthStates.loading() = Loading;
  const factory AuthStates.authenticated(AppUser? user) = Authenticated;
  const factory AuthStates.unauthenticated() = Unauthenticated;
  const factory AuthStates.error(String message) = Error;
}
