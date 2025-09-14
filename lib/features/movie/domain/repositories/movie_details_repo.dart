import 'package:movie_app/core/data/models/media_content_model.dart';
import 'package:movie_app/features/movie/data/models/cast_member_model.dart';
import 'package:movie_app/features/movie/data/models/media_content_details_model.dart';
import 'package:movie_app/features/movie/data/models/media_content_reviews_model.dart';
import 'package:movie_app/features/movie/data/models/trailers_model.dart';

abstract class MovieDetailsRepo {
  Future<TrailersModel?> fetchTrailers(int movieId);

  Future<List<MediaContentModel>> fetchSimilarMovies(int id);

  Future<List<MediaContentModel>> fetchRecommendedMovies(int id);

  Future<MediaContentDetailsModel> fetchMovieDetails(int id);

  Future<List<Review>> fetchUserReviews(int id);

  Future<List<CastMemberModel>> fetchCastMember(int id);
}
