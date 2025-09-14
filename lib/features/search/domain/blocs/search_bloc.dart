import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/search/data/models/media_content_search_model.dart';
import 'package:movie_app/features/search/domain/blocs/search_states.dart';
import 'package:movie_app/features/search/domain/repositories/search_repo.dart';

class SearchBloc extends Cubit<SearchStates> {
  SearchBloc({required this.searchRepo}) : super(SearchStates.initial());

  final SearchRepo searchRepo;

  Future<void> fetchSearchResults(String value) async {
    try {
      emit(SearchStates.loading());
      final List<MediaContentSearchModel> searchData = await searchRepo.fetchSearchResults(value);
      if (searchData.length > 20) {
        searchData.removeRange(20, searchData.length);
      }
      emit(SearchStates.success(searchData: searchData));
    } catch (e) {
      emit(SearchStates.error('Failed to fetch search results'));
    }
  }
}
