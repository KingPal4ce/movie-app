import 'package:flutter_intro_bootcamp_project/core/data/models/media_content_model.dart';

abstract class HomeState {}

// initial
class HomeInitial extends HomeState {}

// loading
class HomeLoading extends HomeState {}

// loaded
class HomeLoaded extends HomeState {
  HomeLoaded({this.trendingWeek, this.trendingDay, this.popularMovies, this.topRatedMovies, this.nowPlayingMovies});
  final List<MediaContentModel>? trendingWeek;
  final List<MediaContentModel>? trendingDay;
  final List<MediaContentModel>? popularMovies;
  final List<MediaContentModel>? topRatedMovies;
  final List<MediaContentModel>? nowPlayingMovies;
}

// errors
class HomeError extends HomeState {
  HomeError(this.message);
  final String message;
}
