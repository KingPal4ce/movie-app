import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_intro_bootcamp_project/features/search/data/models/media_content_search_model.dart';
import 'package:flutter_intro_bootcamp_project/features/search/domain/blocs/search_states.dart';
import 'package:flutter_intro_bootcamp_project/features/search/domain/repositories/search_repo.dart';

class SearchBloc extends Cubit<SearchStates> {
  SearchBloc({required this.searchRepo}) : super(SearchInitial());

  final SearchRepo searchRepo;

  Future<void> fetchSearchResults(String value) async {
    try {
      emit(SearchLoading());
      final List<MediaContentSearchModel> searchData = await searchRepo.fetchSearchResults(value);
      if (searchData.length > 20) {
        searchData.removeRange(20, searchData.length);
      }
      emit(SearchLoaded(searchData: searchData));
    } catch (e) {
      emit(SearchError('Failed to fetch search results'));
      throw Exception('Error in SearchBloc (fetchSearchResults): $e');
    }
  }
}
