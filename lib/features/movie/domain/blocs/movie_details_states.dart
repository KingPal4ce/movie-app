import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_app/core/data/models/media_content_model.dart';
import 'package:movie_app/features/movie/data/models/cast_member_model.dart';
import 'package:movie_app/features/movie/data/models/media_content_details_model.dart';
import 'package:movie_app/features/movie/data/models/trailers_model.dart';

part 'movie_details_states.freezed.dart';

@freezed
abstract class MovieDetailsStates with _$MovieDetailsStates {
  const factory MovieDetailsStates.initial() = _Initial;
  const factory MovieDetailsStates.loading() = _Loading;
  const factory MovieDetailsStates.success({
    final List<MediaContentModel>? similarMovies,
    final List<MediaContentModel>? recommendedMovies,
    final List<Map<String, dynamic>>? reviews,
    final List<CastMemberModel>? castMembers,
    final TrailersModel? trailers,
    final MediaContentDetailsModel? movieDetails,
  }) = _Success;
  const factory MovieDetailsStates.error(String message) = _Error;
}
