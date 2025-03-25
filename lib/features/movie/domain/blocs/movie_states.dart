import 'package:flutter_intro_bootcamp_project/core/data/models/media_content_model.dart';
import 'package:flutter_intro_bootcamp_project/features/movie/data/services/movie_service.dart';

abstract class MovieStates {}

// initial
class MovieInitial extends MovieStates {}

// loading
class MovieLoading extends MovieStates {}

// loaded
class MovieLoaded extends MovieStates {
  MovieLoaded({this.moviesByGenre});
  final Map<MovieGenre, List<MediaContentModel>>? moviesByGenre;
}

// errors
class MovieError extends MovieStates {
  MovieError(this.message);
  final String message;
}
