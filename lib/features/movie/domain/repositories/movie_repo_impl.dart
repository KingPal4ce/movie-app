import 'package:flutter_intro_bootcamp_project/core/data/models/media_content_model.dart';
import 'package:flutter_intro_bootcamp_project/features/movie/data/services/movie_service.dart';
import 'package:flutter_intro_bootcamp_project/features/movie/domain/repositories/movie_repo.dart';

class MovieRepoImpl implements MovieRepo {
  MovieRepoImpl(this.movieService);
  final MovieService movieService;

  @override
  Future<List<MediaContentModel>> fetchMoviesByGenre(MovieGenre genre) async {
    try {
      return await movieService.fetchMoviesByGenre(genre);
    } catch (e) {
      throw Exception('Error in MovieRepoImpl (fetchMoviesByGenre): $e');
    }
  }
}
