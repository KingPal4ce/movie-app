import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_intro_bootcamp_project/core/data/models/media_content_model.dart';
import 'package:flutter_intro_bootcamp_project/core/presentation/widgets/media_content_slider.dart';
import 'package:flutter_intro_bootcamp_project/features/home/domain/blocs/home_bloc.dart';
import 'package:flutter_intro_bootcamp_project/features/home/domain/blocs/home_states.dart';
import 'package:flutter_intro_bootcamp_project/features/movie_details/presentation/screens/movie_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc homeBloc;
  late List<MediaContentModel> trendingMovies;
  late List<MediaContentModel> popularMovies;
  late List<MediaContentModel> topRatedMovies;
  late List<MediaContentModel> nowPlayingMovies;
  int selectedTrending = 1;

  @override
  void initState() {
    super.initState();
    homeBloc = context.read<HomeBloc>();
    homeBloc.fetchMovies();
  }

  void _onTrendingChanged(int? value) {
    if (value != null) {
      setState(() {
        selectedTrending = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.black,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('F I L M F L I X', style: TextStyle(color: Colors.white)),
                Row(
                  children: <Widget>[
                    Text('Trending:', style: TextStyle(fontSize: 16, color: Colors.white)),
                    SizedBox(width: 10),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: DropdownButton<int>(
                          items: const <DropdownMenuItem<int>>[
                            DropdownMenuItem<int>(value: 1, child: Text('Weekly', style: TextStyle(color: Colors.white))),
                            DropdownMenuItem<int>(value: 2, child: Text('Daily', style: TextStyle(color: Colors.white))),
                          ],
                          onChanged: _onTrendingChanged,
                          underline: Container(height: 0),
                          dropdownColor: Colors.black.withValues(alpha: 0.6),
                          icon: Icon(Icons.arrow_drop_down_sharp, color: Colors.amber, size: 30),
                          value: selectedTrending,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            expandedHeight: 450,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: BlocBuilder<HomeBloc, HomeStates>(
                builder: (BuildContext context, HomeStates state) {
                  if (state is HomeLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is HomeError) {
                    return Center(child: Text("Error: ${state.message}"));
                  } else if (state is HomeLoaded) {
                    trendingMovies = selectedTrending == 1 ? state.trendingWeek : state.trendingDay;

                    if (trendingMovies.isEmpty) {
                      return const Center(child: Text('No movies available'));
                    }

                    // Carousel with trending movies
                    return CarouselSlider(
                      items:
                          trendingMovies.map((MediaContentModel media) {
                            return Builder(
                              builder: (BuildContext context) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute<Widget>(builder: (BuildContext context) => MovieDetailsScreen(movieId: media.id)),
                                    );
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        colorFilter: ColorFilter.mode(Colors.black.withValues(alpha: 0.3), BlendMode.darken),
                                        image: NetworkImage('https://image.tmdb.org/t/p/w500${media.posterPath}'),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                      options: CarouselOptions(viewportFraction: 1, autoPlay: true, autoPlayInterval: Duration(seconds: 3), height: 450),
                    );
                  }

                  return Center(child: Text('Something went Wrong'));
                },
              ),
            ),
          ),
          // Movie Sliders
          SliverToBoxAdapter(
            child: BlocBuilder<HomeBloc, HomeStates>(
              builder: (BuildContext context, HomeStates state) {
                if (state is HomeLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is HomeError) {
                  return Center(child: Text("Error: ${state.message}"));
                } else if (state is HomeLoaded) {
                  nowPlayingMovies = state.nowPlayingMovies;
                  popularMovies = state.popularMovies;
                  topRatedMovies = state.topRatedMovies;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      MediaContentSlider(list: nowPlayingMovies, categoryTitle: 'Now Playing', itemCount: nowPlayingMovies.length),
                      MediaContentSlider(list: popularMovies, categoryTitle: 'Popular Movies', itemCount: popularMovies.length),
                      MediaContentSlider(list: topRatedMovies, categoryTitle: 'Top Rated Movies', itemCount: topRatedMovies.length),
                    ],
                  );
                }
                return Center(child: Text('Something went Wrong'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
