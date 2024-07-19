import 'package:bloc/bloc.dart';
import 'package:flutter_onlineshop_app/data/models/responses/cost_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_onlineshop_app/data/datasources/product_remote_datasource.dart';

import '../../../../data/models/responses/product_response_model.dart';

part 'all_product_bloc.freezed.dart';
part 'all_product_event.dart';
part 'all_product_state.dart';

class AllProductBloc extends Bloc<AllProductEvent, AllProductState> {
  final ProductRemoteDatasource _productRemoteDatasource;
  AllProductBloc(
    this._productRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GetAllProducts>((event, emit) async {
      emit(const AllProductState.loading());
      final response = await _productRemoteDatasource.getAllProducts();
      response.fold(
        (l) => emit(const AllProductState.error('Internal Server Error')),
        (r) => emit(AllProductState.loaded(r.data!.data!)),
      );
    });
    // on<_GetByCategory>((event, emit) async {
    //   emit(const _Loading());
    //   final response = await _productRemoteDatasource.getProductByCategory(event.categoryId);
    //   response.fold(
    //     (l) => emit(const AllProductState.error('Internal Server Error')),
    //     (r) => emit(AllProductState.loaded(r.data!.data!)),
    //   );
    // });
  }
}
