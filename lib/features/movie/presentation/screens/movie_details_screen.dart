import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/data/models/media_content_model.dart';
import 'package:movie_app/core/presentation/app_router.dart';
import 'package:movie_app/core/presentation/widgets/media_content_slider.dart';
import 'package:movie_app/core/presentation/widgets/my_loading_indicator.dart';
import 'package:movie_app/features/movie/data/models/cast_member_model.dart';
import 'package:movie_app/features/movie/data/models/media_content_details_model.dart';
import 'package:movie_app/features/movie/data/models/trailers_model.dart';
import 'package:movie_app/features/movie/domain/blocs/movie_details_bloc.dart';
import 'package:movie_app/features/movie/domain/blocs/movie_details_states.dart';
import 'package:movie_app/features/movie/presentation/widgets/cast_list.dart';
import 'package:movie_app/features/movie/presentation/widgets/trailers_player.dart';
import 'package:movie_app/features/movie/presentation/widgets/user_review.dart';

@RoutePage()
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
            return state.maybeWhen(
              loading: () => const MyLoadingIndicator(),
              success: (
                List<MediaContentModel>? similarMovies,
                List<MediaContentModel>? recommendedMovies,
                List<Map<String, dynamic>>? reviews,
                List<CastMemberModel>? castMembers,
                TrailersModel? trailers,
                MediaContentDetailsModel? movieDetails,
              ) =>
                  CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    leading: IconButton(
                      onPressed: () => context.router.back(),
                      icon: const Icon(FontAwesomeIcons.circleArrowLeft),
                      iconSize: 28,
                      color: Colors.white,
                    ),
                    actions: <Widget>[
                      IconButton(
                        onPressed: () {
                          context.router.pushAndPopUntil(NavigationRoute(), predicate: (_) => false);
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
                        child: trailers != null && trailers.key.isNotEmpty
                            ? AspectRatio(aspectRatio: 5 / 3, child: TrailersPlayer(trailerId: trailers.key))
                            : const SizedBox(height: 200, width: 200, child: Center(child: Text('Trailer Unavailable'))),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        if (movieDetails != null) ...<Widget>[
                          const SizedBox(height: 10),

                          // Movie Title
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              movieDetails.title,
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),
                          // Genres
                          if (movieDetails.genres.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: SizedBox(
                                height: 45,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: movieDetails.genres.length,
                                  itemBuilder: (BuildContext context, int index) => Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(10)),
                                    child: Center(child: Text(movieDetails.genreNames[index])),
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
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '${movieDetails.runtime} min',
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),

                          // Overview
                          Padding(padding: EdgeInsets.only(left: 20, top: 10), child: Text('Overview: ', style: GoogleFonts.poppins(fontSize: 18))),
                          const SizedBox(height: 10),
                          movieDetails.overview != ''
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(movieDetails.overview, textAlign: TextAlign.justify),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text('No Overview Available...'),
                                ),

                          // Additional details
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 20),
                            child: Row(
                              children: <Widget>[
                                Text('Release Date: ', style: GoogleFonts.poppins(fontSize: 18)),
                                Text(movieDetails.releaseDate),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 20),
                            child: Row(
                              children: <Widget>[
                                Text('Budget: ', style: GoogleFonts.poppins(fontSize: 18)),
                                Text('\$${movieDetails.budget}'),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 20),
                            child: Row(
                              children: <Widget>[
                                Text('Revenue: ', style: GoogleFonts.poppins(fontSize: 18)),
                                Text('\$${movieDetails.revenue}'),
                              ],
                            ),
                          ),
                        ],

                        // Cast
                        if (castMembers != null && castMembers.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(height: 20),
                              Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    'Cast',
                                    style: GoogleFonts.poppins(fontSize: 18),
                                  )),
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: SizedBox(
                                  height: 160,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                                    itemCount: castMembers.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      if (castMembers.isEmpty) {
                                        return const Center(child: Text('No Cast Members Available'));
                                      }
                                      return Container(
                                        width: 100,
                                        margin: const EdgeInsets.only(right: 10),
                                        child: CastList(castMember: castMembers[index]),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),

                        // Reviews
                        if (reviews != null && reviews.isNotEmpty)
                          Padding(padding: const EdgeInsets.only(left: 20, top: 10), child: UserReview(reviewDetails: reviews)),

                        // Similar Movies
                        if (similarMovies != null && similarMovies.isNotEmpty)
                          MediaContentSlider(
                            list: similarMovies,
                            categoryTitle: 'Similar Movies',
                          ),

                        // Recommended Movies
                        if (recommendedMovies != null && recommendedMovies.isNotEmpty)
                          MediaContentSlider(
                            list: recommendedMovies,
                            categoryTitle: 'Recommended Movies',
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              error: (String message) => Center(child: Text("Error: $message")),
              orElse: () => const Center(child: Text('Something went Wrong')),
            );
          },
        ),
      ),
    );
  }
}
