import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_intro_bootcamp_project/core/presentation/screens/navigation_screen.dart';
import 'package:flutter_intro_bootcamp_project/core/presentation/widgets/media_content_slider.dart';
import 'package:flutter_intro_bootcamp_project/features/movie_details/presentation/widgets/trailers_player.dart';
import 'package:flutter_intro_bootcamp_project/core/presentation/widgets/user_review.dart';
import 'package:flutter_intro_bootcamp_project/features/movie/domain/blocs/movie_states.dart';
import 'package:flutter_intro_bootcamp_project/features/movie_details/domain/blocs/movie_details_bloc.dart';
import 'package:flutter_intro_bootcamp_project/features/movie_details/domain/blocs/movie_details_states.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key, required this.movieId});
  final int movieId;

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  bool _isLoading = true;
  bool _hasError = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final MovieDetailsBloc movieDetailsBloc = context.read<MovieDetailsBloc>();

    try {
      setState(() {
        _isLoading = true;
        _hasError = false;
      });

      // Execute all requests sequentially
      await movieDetailsBloc.fetchMovieDetails(widget.movieId);
      await movieDetailsBloc.fetchTrailers(widget.movieId);
      await movieDetailsBloc.fetchUserReviews(widget.movieId);
      await movieDetailsBloc.fetchSimilarMovies(widget.movieId);
      await movieDetailsBloc.fetchRecommendedMovies(widget.movieId);

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(14, 14, 14, 1),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(FontAwesomeIcons.circleArrowLeft),
          iconSize: 28,
          color: Colors.white,
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute<dynamic>(builder: (BuildContext context) => const NavigationScreen()),
                (Route<dynamic> route) => false,
              );
            },
            iconSize: 25,
            color: Colors.white,
            icon: Icon(FontAwesomeIcons.houseUser),
          ),
        ],
      ),
      body: BlocBuilder<MovieDetailsBloc, MovieDetailsStates>(
        builder: (BuildContext context, MovieDetailsStates state) {
          if (_hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Text('Error: $_errorMessage'), ElevatedButton(onPressed: _loadData, child: const Text('Retry'))],
              ),
            );
          }

          if (_isLoading || state is MovieInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MovieDetailsLoaded) {
            return _buildContent(state);
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildContent(MovieDetailsLoaded state) {
    return Column(
      children: <Widget>[
        state.trailers != null && state.trailers!.key.isNotEmpty
            ? TrailersPlayer(trailerId: state.trailers!.key)
            : SizedBox(height: 200, width: 200, child: Center(child: const Text('Trailer Unavailable'))),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (state.movieDetails != null) ...<Widget>[
                  // Genres
                  if (state.movieDetails!.genres.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.movieDetails!.genres.length,
                        itemBuilder:
                            (BuildContext context, int index) => Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(color: const Color.fromRGBO(25, 25, 25, 1), borderRadius: BorderRadius.circular(10)),
                              child: Text(state.movieDetails!.genreNames[index]),
                            ),
                      ),
                    ),

                  // Runtime
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(left: 10, top: 10),
                        decoration: BoxDecoration(color: const Color.fromRGBO(25, 25, 25, 1), borderRadius: BorderRadius.circular(10)),
                        child: Text('${state.movieDetails!.runtime} min'),
                      ),
                      const Spacer(),
                    ],
                  ),

                  // Overview
                  const Padding(padding: EdgeInsets.only(left: 20, top: 10), child: Text('Movie Story: ')),
                  Padding(padding: const EdgeInsets.only(left: 20, top: 10), child: Text(state.movieDetails!.overview)),
                  if (state.reviews != null)
                    Padding(padding: const EdgeInsets.only(left: 20, top: 10), child: UserReview(reviewDetails: state.reviews!)),

                  // Reviews
                  if (state.reviews != null && state.reviews!.isNotEmpty)
                    Padding(padding: const EdgeInsets.only(left: 20, top: 10), child: UserReview(reviewDetails: state.reviews!)),

                  // Additional details
                  Padding(padding: const EdgeInsets.only(left: 20, top: 20), child: Text('Release Date: ${state.movieDetails!.releaseDate}')),
                  Padding(padding: const EdgeInsets.only(left: 20, top: 20), child: Text('Budget: \$${state.movieDetails!.budget}')),
                  Padding(padding: const EdgeInsets.only(left: 20, top: 20), child: Text('Revenue: \$${state.movieDetails!.revenue}')),
                ],

                // Similar Movies
                if (state.similarMovies != null && state.similarMovies!.isNotEmpty)
                  MediaContentSlider(list: state.similarMovies!, categoryTitle: 'Similar Movies', itemCount: state.similarMovies!.length),

                // Recommended Movies
                if (state.recommendedMovies != null && state.recommendedMovies!.isNotEmpty)
                  MediaContentSlider(list: state.recommendedMovies!, categoryTitle: 'Recommended Movies', itemCount: state.recommendedMovies!.length),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
