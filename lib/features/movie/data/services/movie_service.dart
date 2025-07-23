import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_intro_bootcamp_project/core/data/api_dio_client.dart';
import 'package:flutter_intro_bootcamp_project/core/data/models/media_content_model.dart';

enum MovieGenre {
  action(28),
  adventure(12),
  animation(16),
  comedy(35),
  crime(80),
  documentary(99),
  drama(18),
  family(10751),
  fantasy(14),
  history(36),
  horror(27),
  music(10402),
  mystery(9648),
  romance(10749),
  thriller(53),
  war(10752);

  const MovieGenre(this.id);
  final int id;
}

class MovieService {
  MovieService(this.apiClient);
  final ApiDioClient apiClient;

  final String? apiKey = dotenv.env['TMDB_API_KEY'];

  Future<List<MediaContentModel>> fetchMoviesByGenre(MovieGenre genre) async {
    try {
      final Response<dynamic> response = await apiClient.get('discover/movie?api_key=$apiKey&with_genres=${genre.id}');
      if (response.statusCode == 200 && response.data != null) {
        List<dynamic> moviesJson = response.data!['results'];
        return moviesJson.map((dynamic item) => MediaContentModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch movies for genre: ${genre.name}');
      }
    } catch (e) {
      throw Exception('Error fetching movies for genre: ${genre.name}, Error: $e');
    }
  }
}
