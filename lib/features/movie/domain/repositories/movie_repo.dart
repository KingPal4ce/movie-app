import 'package:movie_app/core/data/models/media_content_model.dart';
import 'package:movie_app/features/movie/data/services/movie_service.dart';

abstract class MovieRepo {
  Future<List<MediaContentModel>> fetchMoviesByGenre(MovieGenre genre);
}
