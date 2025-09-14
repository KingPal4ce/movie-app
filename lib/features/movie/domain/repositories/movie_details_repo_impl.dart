import 'package:movie_app/core/data/models/media_content_model.dart';
import 'package:movie_app/features/movie/data/models/cast_member_model.dart';
import 'package:movie_app/features/movie/data/models/media_content_details_model.dart';
import 'package:movie_app/features/movie/data/models/media_content_reviews_model.dart';
import 'package:movie_app/features/movie/data/models/trailers_model.dart';
import 'package:movie_app/features/movie/data/services/movie_service.dart';
import 'package:movie_app/features/movie/domain/repositories/movie_details_repo.dart';

class MovieDetailsRepoImpl implements MovieDetailsRepo {
  MovieDetailsRepoImpl(this.movieService);
  final MovieService movieService;

  @override
  Future<List<MediaContentModel>> fetchRecommendedMovies(int id) async {
    try {
      return await movieService.fetchRecommendedMovies(id);
    } catch (e) {
      throw Exception('Error in MovieDetailsRepoImpl (fetchRecommendedMovies): $e');
    }
  }

  @override
  Future<List<MediaContentModel>> fetchSimilarMovies(int id) async {
    try {
      return await movieService.fetchSimilarMovies(id);
    } catch (e) {
      throw Exception('Error in MovieDetailsRepoImpl (fetchSimilarMovies): $e');
    }
  }

  @override
  Future<TrailersModel?> fetchTrailers(int movieId) async {
    try {
      return await movieService.fetchTrailers(movieId);
    } catch (e) {
      throw Exception('Error in MovieDetailsRepoImpl (fetchTrailers): $e');
    }
  }

  @override
  Future<List<Review>> fetchUserReviews(int id) async {
    try {
      return await movieService.fetchUserReviews(id);
    } catch (e) {
      throw Exception('Error in MovieDetailsRepoImpl (fetchUserReviews): $e');
    }
  }

  @override
  Future<MediaContentDetailsModel> fetchMovieDetails(int id) async {
    try {
      return await movieService.fetchMovieDetails(id);
    } catch (e) {
      throw Exception('Error in MovieDetailsRepoImpl (fetchMovieDetails): $e');
    }
  }

  @override
  Future<List<CastMemberModel>> fetchCastMember(int id) async {
    try {
      return await movieService.fetchCastMember(id);
    } catch (e) {
      throw Exception('Error in MovieDetailsRepoImpl (fetchCastMember): $e');
    }
  }
}
