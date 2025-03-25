import 'package:flutter_intro_bootcamp_project/core/data/models/media_content_model.dart';
import 'package:flutter_intro_bootcamp_project/core/data/models/trailers_model.dart';
import 'package:flutter_intro_bootcamp_project/features/movie_details/data/models/media_content_details_model.dart';

abstract class MovieDetailsStates {}

// initial
class MovieDetailsInitial extends MovieDetailsStates {}

// loading
class MovieDetailsLoading extends MovieDetailsStates {}

// loaded
class MovieDetailsLoaded extends MovieDetailsStates {
  MovieDetailsLoaded({this.similarMovies, this.recommendedMovies, this.reviews, this.trailers, this.movieDetails});
  final List<MediaContentModel>? similarMovies;
  final List<MediaContentModel>? recommendedMovies;
  final List<Map<String, dynamic>>? reviews;
  final TrailersModel? trailers;
  final MediaContentDetailsModel? movieDetails;
}

// errors
class MovieDetailsError extends MovieDetailsStates {
  MovieDetailsError(this.message);
  final String message;
}
