import 'package:flutter_intro_bootcamp_project/core/data/models/media_content_model.dart';
import 'package:flutter_intro_bootcamp_project/core/data/models/media_content_reviews_model.dart';
import 'package:flutter_intro_bootcamp_project/core/data/models/trailers_model.dart';
import 'package:flutter_intro_bootcamp_project/features/movie_details/data/models/media_content_details_model.dart';
import 'package:flutter_intro_bootcamp_project/features/movie_details/data/services/movie_details_service.dart';
import 'package:flutter_intro_bootcamp_project/features/movie_details/domain/repositories/movie_details_repo.dart';

class MovieDetailsRepoImpl implements MovieDetailsRepo {
  MovieDetailsRepoImpl(this.movieDetailsService);
  final MovieDetailsService movieDetailsService;

  @override
  Future<List<MediaContentModel>> fetchRecommendedMovies(int id) async {
    try {
      return await movieDetailsService.fetchRecommendedMovies(id);
    } catch (e) {
      throw Exception('Error in MovieDetailsRepoImpl (fetchRecommendedMovies): $e');
    }
  }

  @override
  Future<List<MediaContentModel>> fetchSimilarMovies(int id) async {
    try {
      return await movieDetailsService.fetchSimilarMovies(id);
    } catch (e) {
      throw Exception('Error in MovieDetailsRepoImpl (fetchSimilarMovies): $e');
    }
  }

  @override
  Future<TrailersModel?> fetchTrailers(int movieId) async {
    try {
      return await movieDetailsService.fetchTrailers(movieId);
    } catch (e) {
      throw Exception('Error in MovieDetailsRepoImpl (fetchTrailers): $e');
    }
  }

  @override
  Future<List<Review>> fetchUserReviews(int id) async {
    try {
      return await movieDetailsService.fetchUserReviews(id);
    } catch (e) {
      throw Exception('Error in MovieDetailsRepoImpl (fetchUserReviews): $e');
    }
  }

  @override
  Future<MediaContentDetailsModel> fetchMovieDetails(int id) async {
    try {
      return await movieDetailsService.fetchMovieDetails(id);
    } catch (e) {
      throw Exception('Error in MovieDetailsRepoImpl (fetchMovieDetails): $e');
    }
  }
}
