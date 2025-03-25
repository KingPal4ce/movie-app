import 'package:flutter_intro_bootcamp_project/core/data/models/media_content_model.dart';

abstract class HomeRepo {
  Future<List<MediaContentModel>> fetchTrendingWeek();

  Future<List<MediaContentModel>> fetchTrendingDay();

  Future<List<MediaContentModel>> fetchPopularMovies();

  Future<List<MediaContentModel>> fetchTopRatedMovies();

  Future<List<MediaContentModel>> fetchNowPlayingMovies();
}
