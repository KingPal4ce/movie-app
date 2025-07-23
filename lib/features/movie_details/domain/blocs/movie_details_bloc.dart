import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_intro_bootcamp_project/core/data/models/media_content_model.dart';
import 'package:flutter_intro_bootcamp_project/features/movie_details/data/models/cast_member_model.dart';
import 'package:flutter_intro_bootcamp_project/features/movie_details/data/models/media_content_details_model.dart';
import 'package:flutter_intro_bootcamp_project/features/movie_details/data/models/media_content_reviews_model.dart';
// import 'package:flutter_intro_bootcamp_project/features/movie_details/data/models/media_content_reviews_model.dart';
import 'package:flutter_intro_bootcamp_project/features/movie_details/data/models/trailers_model.dart';
import 'package:flutter_intro_bootcamp_project/features/movie_details/domain/blocs/movie_details_states.dart';
import 'package:flutter_intro_bootcamp_project/features/movie_details/domain/repositories/movie_details_repo.dart';

class MovieDetailsBloc extends Cubit<MovieDetailsStates> {
  MovieDetailsBloc({required this.movieDetailsRepo}) : super(MovieDetailsInitial());

  final MovieDetailsRepo movieDetailsRepo;
  MediaContentDetailsModel? _movieDetails;
  TrailersModel? _trailers;
  List<MediaContentModel>? _similarMovies;
  List<MediaContentModel>? _recommendedMovies;
  List<Map<String, dynamic>>? _reviews;
  List<CastMemberModel>? _castMembers;

  Future<void> fetchMovieDetails(int movieId) async {
    try {
      emit(MovieDetailsLoading());
      _trailers = await movieDetailsRepo.fetchTrailers(movieId);
      _movieDetails = await movieDetailsRepo.fetchMovieDetails(movieId);
      _similarMovies = await movieDetailsRepo.fetchSimilarMovies(movieId);
      _recommendedMovies = await movieDetailsRepo.fetchRecommendedMovies(movieId);
      _castMembers = await movieDetailsRepo.fetchCastMember(movieId);
      final List<Review> reviewsList = await movieDetailsRepo.fetchUserReviews(movieId);
      _reviews =
          reviewsList
              .map(
                (Review review) => <String, String>{
                  "name": review.author,
                  "review": review.content,
                  "rating": review.authorDetails.displayRating,
                  "avatarPhoto": review.authorDetails.displayAvatar,
                  "creationDate": review.createdAt.substring(0, 10),
                  "fullReviewUrl": review.url,
                },
              )
              .toList();

      emit(
        MovieDetailsLoaded(
          movieDetails: _movieDetails,
          trailers: _trailers,
          similarMovies: _similarMovies,
          recommendedMovies: _recommendedMovies,
          reviews: _reviews,
          castMembers: _castMembers ?? <CastMemberModel>[],
        ),
      );
    } catch (e) {
      emit(MovieDetailsError('$e'));
    }
  }
}
