import 'package:movie_app/features/search/data/models/media_content_search_model.dart';

abstract class SearchRepo {
  Future<List<MediaContentSearchModel>> fetchSearchResults(String value);
}
