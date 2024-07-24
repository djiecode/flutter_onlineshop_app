import 'package:bloc/bloc.dart';
import 'package:flutter_onlineshop_app/data/datasources/product_remote_datasource.dart';
import 'package:flutter_onlineshop_app/data/models/responses/product_response_model.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/rxdart.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';


const _duration = Duration(seconds: 2);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
}


class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ProductRemoteDatasource _productApi;
  SearchBloc(this._productApi) : super(const _Loading()) {
    on<_ArgumentPass>((event, emit) async {
      // implement product search by category
      final response = await _productApi.getProducts(category: event.keyword);
      response.fold(
        (l) => emit(const SearchState.onError('Internal Server Error')),
        (r) => emit((r.data?.data?.isNotEmpty == true)
            ? SearchState.onLoaded(r.data!.data!)
            : const SearchState.onNotFound()),
      );
    });

    on<_TextChanged>(transformer: debounce(_duration), (event, emit) async {
      // if (event.keyword?.isEmpty ?? true) return emit(const _Empty());
      if ((event.keyword?.isEmpty ?? true) ||
          ((event.keyword?.length ?? 0) <= 3)) return emit(const _Empty());
      emit(const _Loading());
      // implement product search
      final response = await _productApi.getProducts(search: event.keyword);
      response.fold(
        (l) => emit(const SearchState.onError('Internal Server Error')),
        (r) => emit((r.data?.data?.isNotEmpty == true)
            ? SearchState.onLoaded(r.data!.data!)
            : const SearchState.onNotFound()),
      );
    });
  }
}
