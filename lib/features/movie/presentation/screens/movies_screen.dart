import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_intro_bootcamp_project/core/presentation/widgets/media_content_slider.dart';
import 'package:flutter_intro_bootcamp_project/features/movie/data/services/movie_service.dart';
import 'package:flutter_intro_bootcamp_project/features/movie/domain/blocs/movie_bloc.dart';
import 'package:flutter_intro_bootcamp_project/features/movie/domain/blocs/movie_states.dart';

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
          if (state is MovieLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieLoaded) {
            return ListView(
              children:
                  MovieGenre.values
                      .where((MovieGenre genre) => state.moviesByGenre!.containsKey(genre))
                      .map(
                        (MovieGenre genre) => MediaContentSlider(
                          list: state.moviesByGenre![genre]!,
                          categoryTitle: genre.toString().split('.').last[0].toUpperCase() + genre.toString().split('.').last.substring(1),
                          itemCount: state.moviesByGenre![genre]!.length,
                        ),
                      )
                      .toList(),
            );
          } else if (state is MovieError) {
            return Center(child: Text(state.message));
          }
          return const Placeholder();
        },
      ),
    );
  }
}
