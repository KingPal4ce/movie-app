import 'package:flutter_intro_bootcamp_project/core/data/models/media_content_model.dart';
import 'package:flutter_intro_bootcamp_project/core/data/models/media_content_reviews_model.dart';
import 'package:flutter_intro_bootcamp_project/core/data/models/trailers_model.dart';
import 'package:flutter_intro_bootcamp_project/features/movie/data/services/movie_service.dart';
import 'package:flutter_intro_bootcamp_project/features/movie/domain/repositories/movie_repo.dart';
import 'package:flutter_intro_bootcamp_project/features/movie_details/data/models/media_content_details_model.dart';

class MovieRepoImpl implements MovieRepo {
  MovieRepoImpl(this.movieService);
  final MovieService movieService;

  @override
  Future<List<MediaContentModel>> fetchMoviesByGenre(MovieGenre genre) async {
    try {
      return await movieService.fetchMoviesByGenre(genre);
    } catch (e) {
      throw Exception('Error in MovieRepoImpl (fetchMoviesByGenre): $e');
    }
  }

  @override
  Future<List<MediaContentModel>> fetchRecommendedMovies(int id) async {
    try {
      return await movieService.fetchRecommendedMovies(id);
    } catch (e) {
      throw Exception('Error in MovieRepoImpl (fetchRecommendedMovies): $e');
    }
  }

  @override
  Future<List<MediaContentModel>> fetchSimilarMovies(int id) async {
    try {
      return await movieService.fetchSimilarMovies(id);
    } catch (e) {
      throw Exception('Error in MovieRepoImpl (fetchSimilarMovies): $e');
    }
  }

  @override
  Future<TrailersModel?> fetchTrailers(int movieId) async {
    try {
      return await movieService.fetchTrailers(movieId);
    } catch (e) {
      throw Exception('Error in MovieRepoImpl (fetchTrailers): $e');
    }
  }

  @override
  Future<List<Review>> fetchUserReviews(int id) async {
    try {
      return await movieService.fetchUserReviews(id);
    } catch (e) {
      throw Exception('Error in MovieRepoImpl (fetchUserReviews): $e');
    }
  }

  @override
  Future<MediaContentDetailsModel> fetchMovieDetails(int id) async {
    try {
      return await movieService.fetchMovieDetails(id);
    } catch (e) {
      throw Exception('Error in MovieRepoImpl (fetchMovieDetails): $e');
    }
  }
}
