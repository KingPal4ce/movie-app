import 'package:flutter_intro_bootcamp_project/core/data/models/media_content_model.dart';

abstract class HomeStates {}

// initial
class HomeInitial extends HomeStates {}

// loading
class HomeLoading extends HomeStates {}

// loaded
class HomeLoaded extends HomeStates {
  HomeLoaded({
    required this.trendingWeek,
    required this.trendingDay,
    required this.popularMovies,
    required this.topRatedMovies,
    required this.nowPlayingMovies,
  });
  final List<MediaContentModel> trendingWeek;
  final List<MediaContentModel> trendingDay;
  final List<MediaContentModel> popularMovies;
  final List<MediaContentModel> topRatedMovies;
  final List<MediaContentModel> nowPlayingMovies;
}

// errors
class HomeError extends HomeStates {
  HomeError(this.message);
  final String message;
}
