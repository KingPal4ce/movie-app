import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_intro_bootcamp_project/core/data/api_dio_client.dart';
import 'package:flutter_intro_bootcamp_project/core/data/models/media_content_model.dart';
import 'package:flutter_intro_bootcamp_project/features/movie_details/data/models/cast_member_model.dart';
import 'package:flutter_intro_bootcamp_project/features/movie_details/data/models/media_content_details_model.dart';
import 'package:flutter_intro_bootcamp_project/features/movie_details/data/models/media_content_reviews_model.dart';
import 'package:flutter_intro_bootcamp_project/features/movie_details/data/models/trailers_model.dart';

class MovieDetailsService {
  MovieDetailsService(this.apiClient);
  final ApiDioClient apiClient;

  final String? apiKey = dotenv.env['TMDB_API_KEY'];

  Future<TrailersModel?> fetchTrailers(int movieId) async {
    try {
      final Response<dynamic> response = await apiClient.get('movie/$movieId/videos?api_key=$apiKey');
      if (response.statusCode == 200 && response.data != null) {
        List<dynamic> videos = response.data!['results'];
        if (videos.isNotEmpty) {
          return TrailersModel.fromJson(videos.first);
        } else {
          return null; // Return null if no videos found
        }
      } else {
        throw Exception('Failed to fetch trailers');
      }
    } catch (e) {
      throw Exception('Error fetching trailers: $e');
    }
  }

  Future<List<MediaContentModel>> fetchSimilarMovies(int id) async {
    try {
      final Response<dynamic> response = await apiClient.get('movie/$id/similar?api_key=$apiKey');
      if (response.statusCode == 200 && response.data != null) {
        List<dynamic> similarMoviesJson = response.data!['results'];
        return similarMoviesJson.map((dynamic item) => MediaContentModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch similar movies data');
      }
    } catch (e) {
      throw Exception('Error fetching similar movies data: $e');
    }
  }

  Future<List<MediaContentModel>> fetchRecommendedMovies(int id) async {
    try {
      final Response<dynamic> response = await apiClient.get('movie/$id/recommendations?api_key=$apiKey');
      if (response.statusCode == 200 && response.data != null) {
        List<dynamic> recommendedMoviesJson = response.data!['results'];
        return recommendedMoviesJson.map((dynamic item) => MediaContentModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch recommended movies data');
      }
    } catch (e) {
      throw Exception('Error fetching recommended movies data: $e');
    }
  }

  Future<MediaContentDetailsModel> fetchMovieDetails(int id) async {
    try {
      final Response<dynamic> response = await apiClient.get('movie/$id?api_key=$apiKey');
      if (response.statusCode == 200 && response.data != null) {
        return MediaContentDetailsModel.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch movie details data');
      }
    } catch (e) {
      throw Exception('Error fetching movie details data: $e');
    }
  }

  Future<List<Review>> fetchUserReviews(int id) async {
    try {
      final Response<dynamic> response = await apiClient.get('movie/$id/reviews?api_key=$apiKey');
      if (response.statusCode == 200 && response.data != null) {
        List<dynamic> userReviewsJson = response.data!['results'];
        return userReviewsJson.map((dynamic item) => Review.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch movie user reviews data');
      }
    } catch (e) {
      throw Exception('Error fetching movie user reviews data: $e');
    }
  }

  Future<List<CastMemberModel>> fetchCastMember(int id) async {
    try {
      final Response<dynamic> response = await apiClient.get('movie/$id/credits?api_key=$apiKey');
      if (response.statusCode == 200 && response.data != null) {
        List<dynamic> castMemberJson = response.data!['cast'];
        return castMemberJson.map((dynamic item) => CastMemberModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch cast members data');
      }
    } catch (e) {
      throw Exception('Error fetching cast members data: $e');
    }
  }
}
