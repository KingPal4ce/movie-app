import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_intro_bootcamp_project/core/data/models/media_content_model.dart';
import 'package:flutter_intro_bootcamp_project/core/presentation/widgets/media_content_slider.dart';
import 'package:flutter_intro_bootcamp_project/features/home/domain/blocs/home_bloc.dart';

class Movies extends StatefulWidget {
  const Movies({super.key});

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  List<MediaContentModel> popularMovies = <MediaContentModel>[];
  List<MediaContentModel> topRatedMovies = <MediaContentModel>[];
  List<MediaContentModel> nowPlayingMovies = <MediaContentModel>[];

  Future<void> _moviesList() async {
    final HomeBloc homeBloc = context.read<HomeBloc>();
    popularMovies = await homeBloc.fetchPopularMovies();
    topRatedMovies = await homeBloc.fetchTopRatedMovies();
    nowPlayingMovies = await homeBloc.fetchNowPlayingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: _moviesList(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Column(children: <Widget>[CircularProgressIndicator()]));
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              MediaContentSlider(list: nowPlayingMovies, categoryTitle: 'Now Playing', itemCount: nowPlayingMovies.length),
              MediaContentSlider(list: popularMovies, categoryTitle: 'Popular Movies', itemCount: popularMovies.length),
              MediaContentSlider(list: topRatedMovies, categoryTitle: 'Top Rated Movies', itemCount: topRatedMovies.length),
            ],
          );
        }
      },
    );
  }
}
