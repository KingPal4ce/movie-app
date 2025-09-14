import 'package:movie_app/core/data/models/media_content_model.dart';
import 'package:movie_app/features/movie/data/services/movie_service.dart';
import 'package:movie_app/features/movie/domain/repositories/movie_repo.dart';

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
