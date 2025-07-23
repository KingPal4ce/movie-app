import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_intro_bootcamp_project/core/data/models/media_content_model.dart';
import 'package:flutter_intro_bootcamp_project/features/home/domain/blocs/home_states.dart';
import 'package:flutter_intro_bootcamp_project/features/home/domain/repositories/home_repo.dart';

class HomeBloc extends Cubit<HomeStates> {
  HomeBloc({required this.homeRepo}) : super(HomeInitial());

  final HomeRepo homeRepo;
  late List<MediaContentModel> nowPlayingMovies;
  late List<MediaContentModel> topRatedMovies;
  late List<MediaContentModel> popularMovies;
  late List<MediaContentModel> trendingDay;
  late List<MediaContentModel> trendingWeek;

  Future<void> fetchMovies() async {
    try {
      emit(HomeLoading());
      trendingWeek = await homeRepo.fetchTrendingWeek();
      trendingDay = await homeRepo.fetchTrendingDay();
      popularMovies = await homeRepo.fetchPopularMovies();
      topRatedMovies = await homeRepo.fetchTopRatedMovies();
      nowPlayingMovies = await homeRepo.fetchNowPlayingMovies();
      emit(
        HomeLoaded(
          trendingWeek: trendingWeek,
          trendingDay: trendingDay,
          popularMovies: popularMovies,
          topRatedMovies: topRatedMovies,
          nowPlayingMovies: nowPlayingMovies,
        ),
      );
    } catch (e) {
      emit(HomeError('Failed to fetch movies: $e'));
    }
  }
}
