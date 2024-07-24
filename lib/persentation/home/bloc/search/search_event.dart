part of 'search_bloc.dart';

@freezed
class SearchEvent with _$SearchEvent {
  const factory SearchEvent.started() = _Started;
  const factory SearchEvent.onTextChanged(String? keyword) = _TextChanged;
  const factory SearchEvent.onPassingArgument(String? keyword) = _ArgumentPass;
}
