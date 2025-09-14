import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/data/models/media_content_model.dart';
import 'package:movie_app/features/movie/data/services/movie_service.dart';
import 'package:movie_app/features/movie/domain/blocs/movie_states.dart';
import 'package:movie_app/features/movie/domain/repositories/movie_repo.dart';

class MovieBloc extends Cubit<MovieStates> {
  MovieBloc({required this.movieRepo}) : super(MovieStates.initial());

  final MovieRepo movieRepo;
  final Map<MovieGenre, List<MediaContentModel>> _moviesByGenre = <MovieGenre, List<MediaContentModel>>{};

  Future<void> fetchMoviesByGenre(MovieGenre genre) async {
    try {
      emit(MovieStates.loading());
      final List<MediaContentModel> movies = await movieRepo.fetchMoviesByGenre(genre);
      _moviesByGenre[genre] = movies;
      emit(MovieStates.success(moviesByGenre: Map<MovieGenre, List<MediaContentModel>>.from(_moviesByGenre)));
    } catch (e) {
      emit(MovieStates.error('Failed to fetch movies by genre: $e'));
    }
  }
}
