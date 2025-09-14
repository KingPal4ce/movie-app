import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_app/core/data/models/media_content_model.dart';
import 'package:movie_app/features/movie/data/services/movie_service.dart';

part 'movie_states.freezed.dart';

@freezed
abstract class MovieStates with _$MovieStates {
  const factory MovieStates.initial() = _Initial;
  const factory MovieStates.loading() = _Loading;
  const factory MovieStates.success({
    final Map<MovieGenre, List<MediaContentModel>>? moviesByGenre,
  }) = _Success;
  const factory MovieStates.error(String message) = _Error;
}
