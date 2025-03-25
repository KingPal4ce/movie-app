import 'package:flutter_intro_bootcamp_project/features/search/data/models/media_content_search_model.dart';

abstract class SearchStates {}

// initial
class SearchInitial extends SearchStates {}

// loading
class SearchLoading extends SearchStates {}

// loaded
class SearchLoaded extends SearchStates {
  SearchLoaded({this.searchData});
  final List<MediaContentSearchModel>? searchData;
}

// errors
class SearchError extends SearchStates {
  SearchError(this.message);
  final String message;
}
