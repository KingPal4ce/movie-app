import 'package:flutter_intro_bootcamp_project/core/data/models/media_content_details_model.dart';
import 'package:flutter_intro_bootcamp_project/core/data/models/media_content_model.dart';
import 'package:flutter_intro_bootcamp_project/core/data/models/media_content_reviews_model.dart';
import 'package:flutter_intro_bootcamp_project/core/data/models/trailers_model.dart';
import 'package:flutter_intro_bootcamp_project/features/movie/data/services/movie_service.dart';

abstract class MovieRepo {
  Future<List<MediaContentModel>> fetchMoviesByGenre(MovieGenre genre);

  Future<TrailersModel?> fetchTrailers(int movieId);

  Future<List<MediaContentModel>> fetchSimilarMovies(int id);

  Future<List<MediaContentModel>> fetchRecommendedMovies(int id);

  Future<MediaContentDetailsModel> fetchMovieDetails(int id);

  Future<List<Review>> fetchUserReviews(int id);
}
