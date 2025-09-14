import 'package:movie_app/core/data/models/media_content_model.dart';
import 'package:movie_app/features/home/data/services/home_service.dart';
import 'package:movie_app/features/home/domain/repositories/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  HomeRepoImpl(this.homeService);
  final HomeService homeService;

  @override
  Future<List<MediaContentModel>> fetchTrendingWeek() async {
    try {
      return await homeService.fetchTrendingWeek();
    } catch (e) {
      throw Exception('Error in HomeRepoImpl (fetchTrendingWeek): $e');
    }
  }

  @override
  Future<List<MediaContentModel>> fetchTrendingDay() async {
    try {
      return await homeService.fetchTrendingDay();
    } catch (e) {
      throw Exception('Error in HomeRepoImpl (fetchTrendingDay): $e');
    }
  }

  @override
  Future<List<MediaContentModel>> fetchPopularMovies() async {
    try {
      return await homeService.fetchPopularMovies();
    } catch (e) {
      throw Exception('Error in HomeRepoImpl (fetchPopularMovies): $e');
    }
  }

  @override
  Future<List<MediaContentModel>> fetchTopRatedMovies() async {
    try {
      return await homeService.fetchTopRatedMovies();
    } catch (e) {
      throw Exception('Error in HomeRepoImpl (fetchTopRatedMovies): $e');
    }
  }

  @override
  Future<List<MediaContentModel>> fetchNowPlayingMovies() async {
    try {
      return await homeService.fetchNowPlayingMovies();
    } catch (e) {
      throw Exception('Error in HomeRepoImpl (fetchNowPlayingMovies): $e');
    }
  }
}
