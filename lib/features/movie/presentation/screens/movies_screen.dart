import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/data/models/media_content_model.dart';
import 'package:movie_app/core/presentation/widgets/media_content_slider.dart';
import 'package:movie_app/core/presentation/widgets/my_loading_indicator.dart';
import 'package:movie_app/features/movie/data/services/movie_service.dart';
import 'package:movie_app/features/movie/domain/blocs/movie_bloc.dart';
import 'package:movie_app/features/movie/domain/blocs/movie_states.dart';

@RoutePage()
class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  @override
  void initState() {
    super.initState();
    final MovieBloc movieBloc = context.read<MovieBloc>();
    for (MovieGenre genre in MovieGenre.values) {
      movieBloc.fetchMoviesByGenre(genre);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('M O V I E S')),
      body: BlocBuilder<MovieBloc, MovieStates>(
        builder: (BuildContext context, MovieStates state) {
          return state.maybeWhen(
            loading: () => const MyLoadingIndicator(),
            success: (Map<MovieGenre, List<MediaContentModel>>? moviesByGenre) => ListView(
              children: MovieGenre.values
                  .where((MovieGenre genre) => moviesByGenre!.containsKey(genre))
                  .map(
                    (MovieGenre genre) => MediaContentSlider(
                      list: moviesByGenre![genre]!,
                      categoryTitle: genre.toString().split('.').last[0].toUpperCase() + genre.toString().split('.').last.substring(1),
                    ),
                  )
                  .toList(),
            ),
            error: (String message) => Center(child: Text(message)),
            orElse: () => const Text('Something Went Wrong'),
          );
        },
      ),
    );
  }
}
