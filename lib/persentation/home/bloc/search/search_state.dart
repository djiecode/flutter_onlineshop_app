part of 'search_bloc.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.onEmpty() = _Empty;
  const factory SearchState.onLoading() = _Loading;
  const factory SearchState.onLoaded(List<Product> products) = _Loaded;
  const factory SearchState.onNotFound() = _NotFound;
  const factory SearchState.onError(String message) = _Error;
}
