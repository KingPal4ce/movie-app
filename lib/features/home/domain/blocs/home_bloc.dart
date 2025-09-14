import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/data/models/media_content_model.dart';
import 'package:movie_app/features/home/domain/blocs/home_states.dart';
import 'package:movie_app/features/home/domain/repositories/home_repo.dart';

class HomeBloc extends Cubit<HomeStates> {
  HomeBloc({required this.homeRepo}) : super(HomeStates.initial());

  final HomeRepo homeRepo;
  late List<MediaContentModel> nowPlayingMovies;
  late List<MediaContentModel> topRatedMovies;
  late List<MediaContentModel> popularMovies;
  late List<MediaContentModel> trendingDay;
  late List<MediaContentModel> trendingWeek;

  Future<void> fetchMovies() async {
    try {
      emit(HomeStates.loading());
      trendingWeek = await homeRepo.fetchTrendingWeek();
      trendingDay = await homeRepo.fetchTrendingDay();
      popularMovies = await homeRepo.fetchPopularMovies();
      topRatedMovies = await homeRepo.fetchTopRatedMovies();
      nowPlayingMovies = await homeRepo.fetchNowPlayingMovies();
      emit(
        HomeStates.success(
          trendingWeek: trendingWeek,
          trendingDay: trendingDay,
          popularMovies: popularMovies,
          topRatedMovies: topRatedMovies,
          nowPlayingMovies: nowPlayingMovies,
        ),
      );
    } catch (e) {
      emit(HomeStates.error('Failed to fetch movies: $e'));
    }
  }
}
