import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_intro_bootcamp_project/core/data/models/media_content_model.dart';
import 'package:flutter_intro_bootcamp_project/features/movie/data/services/movie_service.dart';
import 'package:flutter_intro_bootcamp_project/features/movie/domain/blocs/movie_states.dart';
import 'package:flutter_intro_bootcamp_project/features/movie/domain/repositories/movie_repo.dart';

class MovieBloc extends Cubit<MovieStates> {
  MovieBloc({required this.movieRepo}) : super(MovieInitial());

  final MovieRepo movieRepo;
  final Map<MovieGenre, List<MediaContentModel>> _moviesByGenre = <MovieGenre, List<MediaContentModel>>{};

  Future<void> fetchMoviesByGenre(MovieGenre genre) async {
    try {
      emit(MovieLoading());
      final List<MediaContentModel> movies = await movieRepo.fetchMoviesByGenre(genre);
      _moviesByGenre[genre] = movies;
      emit(MovieLoaded(moviesByGenre: _moviesByGenre));
    } catch (e) {
      emit(MovieError('Failed to fetch movies by genre: $e'));
      throw Exception('Error in MovieBloc (fetchMoviesByGenre): $e');
    }
  }

  void resetToMovieListState() {
    if (state is! MovieLoaded) {
      emit(MovieLoaded(moviesByGenre: _moviesByGenre));
    }
  }
}
