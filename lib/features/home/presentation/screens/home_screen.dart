import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_intro_bootcamp_project/core/data/models/media_content_model.dart';
import 'package:flutter_intro_bootcamp_project/features/home/domain/blocs/home_bloc.dart';
import 'package:flutter_intro_bootcamp_project/features/home/presentation/widgets/movies.dart';
import 'package:flutter_intro_bootcamp_project/features/movie_details/presentation/screens/movie_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTrending = 1;
  late Future<List<MediaContentModel>> _trendingFuture;

  @override
  void initState() {
    super.initState();
    _trendingFuture = _fetchTrending();
  }

  Future<List<MediaContentModel>> _fetchTrending() {
    final HomeBloc homeBloc = context.read<HomeBloc>();

    if (selectedTrending == 1) {
      return homeBloc.fetchTrendingWeek();
    } else {
      return homeBloc.fetchTrendingDay();
    }
  }

  void _onTrendingChanged(int? value) {
    if (value != null) {
      setState(() {
        selectedTrending = value;
        _trendingFuture = _fetchTrending(); // Refresh posters when changed
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('F I L M F L I X'),
                Row(
                  children: <Widget>[
                    Text('Trending:', style: TextStyle(fontSize: 16)),
                    SizedBox(width: 10),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: DropdownButton<int>(
                          items: const <DropdownMenuItem<int>>[
                            DropdownMenuItem<int>(value: 1, child: Text('Weekly')),
                            DropdownMenuItem<int>(value: 2, child: Text('Daily')),
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
              background: FutureBuilder<List<MediaContentModel>>(
                future: _trendingFuture,
                builder: (BuildContext context, AsyncSnapshot<List<MediaContentModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text("No data available"));
                  }

                  // Carousel with trending movies/shows
                  return CarouselSlider(
                    items:
                        snapshot.data!.map((MediaContentModel media) {
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
                },
              ),
            ),
          ),
          // sliver items
          SliverToBoxAdapter(child: Movies()),
        ],
      ),
    );
  }
}
