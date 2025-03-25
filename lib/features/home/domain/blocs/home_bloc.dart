import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_intro_bootcamp_project/core/data/models/media_content_model.dart';
import 'package:flutter_intro_bootcamp_project/features/home/domain/blocs/home_state.dart';
import 'package:flutter_intro_bootcamp_project/features/home/domain/repositories/home_repo.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc({required this.homeRepo}) : super(HomeInitial());

  final HomeRepo homeRepo;

  Future<List<MediaContentModel>> fetchTrendingWeek() async {
    try {
      emit(HomeLoading());
      return await homeRepo.fetchTrendingWeek();
    } catch (e) {
      emit(HomeError('Failed to fetch trending week: $e'));
      throw Exception('Error in HomeBloc (fetchTrendingWeek): $e');
    }
  }

  Future<List<MediaContentModel>> fetchTrendingDay() async {
    try {
      emit(HomeLoading());
      return await homeRepo.fetchTrendingDay();
    } catch (e) {
      emit(HomeError('Failed to fetch trending day: $e'));
      throw Exception('Error in HomeBloc (fetchTrendingDay): $e');
    }
  }

  Future<List<MediaContentModel>> fetchPopularMovies() async {
    try {
      emit(HomeLoading());
      return await homeRepo.fetchPopularMovies();
    } catch (e) {
      emit(HomeError('Failed to fetch popular movies: $e'));
      throw Exception('Error in HomeBloc (fetchPopularMovies): $e');
    }
  }

  Future<List<MediaContentModel>> fetchTopRatedMovies() async {
    try {
      emit(HomeLoading());
      return await homeRepo.fetchTopRatedMovies();
    } catch (e) {
      emit(HomeError('Failed to fetch top rated movies: $e'));
      throw Exception('Error in HomeBloc (fetchTopRatedMovies): $e');
    }
  }

  Future<List<MediaContentModel>> fetchNowPlayingMovies() async {
    try {
      emit(HomeLoading());
      return await homeRepo.fetchNowPlayingMovies();
    } catch (e) {
      emit(HomeError('Failed to fetch now playing movies: $e'));
      throw Exception('Error in HomeBloc (fetchNowPlayingMovies): $e');
    }
  }
}
