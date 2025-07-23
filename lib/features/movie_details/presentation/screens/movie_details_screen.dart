import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_intro_bootcamp_project/core/presentation/screens/navigation_screen.dart';
import 'package:flutter_intro_bootcamp_project/core/presentation/widgets/media_content_slider.dart';
import 'package:flutter_intro_bootcamp_project/features/movie_details/presentation/widgets/cast_list.dart';
import 'package:flutter_intro_bootcamp_project/features/movie_details/presentation/widgets/trailers_player.dart';
import 'package:flutter_intro_bootcamp_project/features/movie_details/presentation/widgets/user_review.dart';
import 'package:flutter_intro_bootcamp_project/features/movie_details/domain/blocs/movie_details_bloc.dart';
import 'package:flutter_intro_bootcamp_project/features/movie_details/domain/blocs/movie_details_states.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key, required this.movieId});
  final int movieId;

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late MovieDetailsBloc movieDetailsBloc;

  @override
  void initState() {
    super.initState();
    movieDetailsBloc = context.read<MovieDetailsBloc>();
    movieDetailsBloc.fetchMovieDetails(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<MovieDetailsBloc, MovieDetailsStates>(
          builder: (BuildContext context, MovieDetailsStates state) {
            if (state is MovieDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MovieDetailsError) {
              return Center(child: Text("Error: ${state.message}"));
            } else if (state is MovieDetailsLoaded) {
              return _movieDetails(state);
            }
            return const Center(child: Text('Something went Wrong'));
          },
        ),
      ),
    );
  }

  Widget _movieDetails(MovieDetailsLoaded state) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          automaticallyImplyLeading: false,
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
          backgroundColor: Color.fromRGBO(18, 18, 18, 0.5),
          pinned: true,
          expandedHeight: MediaQuery.of(context).size.height * 0.3,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            background: Center(
              child:
                  state.trailers != null && state.trailers!.key.isNotEmpty
                      ? AspectRatio(aspectRatio: 16 / 9, child: TrailersPlayer(trailerId: state.trailers!.key))
                      : const SizedBox(height: 200, width: 200, child: Center(child: Text('Trailer Unavailable'))),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (state.movieDetails != null) ...<Widget>[
                const SizedBox(height: 10),

                // Movie Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Title: ${state.movieDetails!.title}', style: GoogleFonts.poppins(fontSize: 22)),
                ),

                const SizedBox(height: 10),
                // Genres
                if (state.movieDetails!.genres.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.movieDetails!.genres.length,
                        itemBuilder:
                            (BuildContext context, int index) => Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(color: const Color.fromRGBO(25, 25, 25, 1), borderRadius: BorderRadius.circular(10)),
                              child: Center(child: Text(state.movieDetails!.genreNames[index])),
                            ),
                      ),
                    ),
                  ),

                // Runtime
                Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(left: 20, top: 10),
                      decoration: BoxDecoration(color: const Color.fromRGBO(25, 25, 25, 1), borderRadius: BorderRadius.circular(10)),
                      child: Text('${state.movieDetails!.runtime} min'),
                    ),
                    const Spacer(),
                  ],
                ),

                // Overview
                Padding(padding: EdgeInsets.only(left: 20, top: 10), child: Text('Overview: ', style: GoogleFonts.poppins(fontSize: 18))),
                const SizedBox(height: 10),
                state.movieDetails!.overview != ''
                    ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(state.movieDetails!.overview, textAlign: TextAlign.justify),
                    )
                    : Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Text('No Overview Available...')),

                // Additional details
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Row(
                    children: <Widget>[Text('Release Date: ', style: GoogleFonts.poppins(fontSize: 18)), Text(state.movieDetails!.releaseDate)],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Row(children: <Widget>[Text('Budget: ', style: GoogleFonts.poppins(fontSize: 18)), Text('\$${state.movieDetails!.budget}')]),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Row(
                    children: <Widget>[Text('Revenue: ', style: GoogleFonts.poppins(fontSize: 18)), Text('\$${state.movieDetails!.revenue}')],
                  ),
                ),
              ],

              // Cast
              if (state.castMembers != null && state.castMembers!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Text('Cast', style: GoogleFonts.poppins(fontSize: 18))),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        height: 160,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                          itemCount: state.castMembers!.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (state.castMembers == null || state.castMembers!.isEmpty) {
                              return const Center(child: Text('No Cast Members Available'));
                            }
                            return Container(
                              width: 100,
                              margin: const EdgeInsets.only(right: 10),
                              child: CastList(castMember: state.castMembers![index]),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),

              // Reviews
              if (state.reviews != null && state.reviews!.isNotEmpty)
                Padding(padding: const EdgeInsets.only(left: 20, top: 10), child: UserReview(reviewDetails: state.reviews!)),

              // Similar Movies
              if (state.similarMovies != null && state.similarMovies!.isNotEmpty)
                MediaContentSlider(list: state.similarMovies!, categoryTitle: 'Similar Movies', itemCount: state.similarMovies!.length),

              // Recommended Movies
              if (state.recommendedMovies != null && state.recommendedMovies!.isNotEmpty)
                MediaContentSlider(list: state.recommendedMovies!, categoryTitle: 'Recommended Movies', itemCount: state.recommendedMovies!.length),
            ],
          ),
        ),
      ],
    );
  }
}
