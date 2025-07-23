import 'package:flutter_intro_bootcamp_project/core/data/models/media_content_model.dart';
import 'package:flutter_intro_bootcamp_project/features/movie/data/services/movie_service.dart';

abstract class MovieRepo {
  Future<List<MediaContentModel>> fetchMoviesByGenre(MovieGenre genre);
}
