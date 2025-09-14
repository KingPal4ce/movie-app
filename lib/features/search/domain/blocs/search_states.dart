import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_app/features/search/data/models/media_content_search_model.dart';

part 'search_states.freezed.dart';

@freezed
abstract class SearchStates with _$SearchStates {
  const factory SearchStates.initial() = _Initial;
  const factory SearchStates.loading() = _Loading;
  const factory SearchStates.success({
    required final List<MediaContentSearchModel> searchData,
  }) = _Success;
  const factory SearchStates.error(String message) = _Error;
}
