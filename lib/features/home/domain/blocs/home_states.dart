import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_app/core/data/models/media_content_model.dart';

part 'home_states.freezed.dart';

@freezed
abstract class HomeStates with _$HomeStates {
  const factory HomeStates.initial() = _Initial;
  const factory HomeStates.loading() = _Loading;
  const factory HomeStates.success({
    required final List<MediaContentModel> trendingWeek,
    required final List<MediaContentModel> trendingDay,
    required final List<MediaContentModel> popularMovies,
    required final List<MediaContentModel> topRatedMovies,
    required final List<MediaContentModel> nowPlayingMovies,
  }) = _Success;
  const factory HomeStates.error(String message) = _Error;
}
