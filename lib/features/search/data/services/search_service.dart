import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_intro_bootcamp_project/core/api_dio_client.dart';
import 'package:flutter_intro_bootcamp_project/features/search/data/models/media_content_search_model.dart';

class SearchService {
  SearchService(this.apiClient);
  final ApiDioClient apiClient;

  final String? apiKey = dotenv.env['TMDB_API_KEY'];

  Future<List<MediaContentSearchModel>> fetchSearchResults(String value) async {
    try {
      final Response<dynamic> response = await apiClient.get('search/movie?api_key=$apiKey&query=$value');
      if (response.statusCode == 200 && response.data != null) {
        List<dynamic> similarMoviesJson = response.data!['results'];
        return similarMoviesJson.map((dynamic item) => MediaContentSearchModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch search results data');
      }
    } catch (e) {
      throw Exception('Error fetching search results data: $e');
    }
  }
}
