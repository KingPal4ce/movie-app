import 'package:flutter_intro_bootcamp_project/features/search/data/models/media_content_search_model.dart';
import 'package:flutter_intro_bootcamp_project/features/search/data/services/search_service.dart';
import 'package:flutter_intro_bootcamp_project/features/search/domain/repositories/search_repo.dart';

class SearchRepoImpl implements SearchRepo {
  SearchRepoImpl({required this.searchService});
  final SearchService searchService;

  @override
  Future<List<MediaContentSearchModel>> fetchSearchResults(String value) async {
    try {
      return await searchService.fetchSearchResults(value);
    } catch (e) {
      throw Exception('Error in SearchRepoImpl (fetchSearchResults): $e');
    }
  }
}
