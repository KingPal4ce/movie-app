import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_intro_bootcamp_project/core/api_dio_client.dart';
import 'package:flutter_intro_bootcamp_project/core/data/models/media_content_model.dart';

class HomeService {
  HomeService(this.apiClient);
  final ApiDioClient apiClient;

  final String? apiKey = dotenv.env['TMDB_API_KEY'];

  Future<List<MediaContentModel>> fetchTrendingWeek() async {
    try {
      final Response<dynamic> response = await apiClient.get('trending/all/week?api_key=$apiKey');
      if (response.statusCode == 200 && response.data != null) {
        List<dynamic> trendingWeekJson = response.data!['results'];
        return trendingWeekJson.map((dynamic item) => MediaContentModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch trending data');
      }
    } catch (e) {
      throw Exception('Error fetching trending data: $e');
    }
  }

  Future<List<MediaContentModel>> fetchTrendingDay() async {
    try {
      final Response<dynamic> response = await apiClient.get('trending/all/day?api_key=$apiKey');
      if (response.statusCode == 200 && response.data != null) {
        List<dynamic> trendingDayJson = response.data!['results'];
        return trendingDayJson.map((dynamic item) => MediaContentModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch trending data');
      }
    } catch (e) {
      throw Exception('Error fetching trending data: $e');
    }
  }

  Future<List<MediaContentModel>> fetchPopularMovies() async {
    try {
      final Response<dynamic> response = await apiClient.get('movie/popular?api_key=$apiKey');
      if (response.statusCode == 200 && response.data != null) {
        List<dynamic> popularMoviesJson = response.data!['results'];
        return popularMoviesJson.map((dynamic item) => MediaContentModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch popular movies data');
      }
    } catch (e) {
      throw Exception('Error fetching popular movies data: $e');
    }
  }

  Future<List<MediaContentModel>> fetchTopRatedMovies() async {
    try {
      final Response<dynamic> response = await apiClient.get('movie/top_rated?api_key=$apiKey');
      if (response.statusCode == 200 && response.data != null) {
        List<dynamic> topRatedMoviesJson = response.data!['results'];
        return topRatedMoviesJson.map((dynamic item) => MediaContentModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch top rated movies data');
      }
    } catch (e) {
      throw Exception('Error fetching top rated movies data: $e');
    }
  }

  Future<List<MediaContentModel>> fetchNowPlayingMovies() async {
    try {
      final Response<dynamic> response = await apiClient.get('movie/now_playing?api_key=$apiKey');
      if (response.statusCode == 200 && response.data != null) {
        List<dynamic> nowPlayingMoviesJson = response.data!['results'];
        return nowPlayingMoviesJson.map((dynamic item) => MediaContentModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch now playing movies data');
      }
    } catch (e) {
      throw Exception('Error fetching now playing movies data: $e');
    }
  }
}
