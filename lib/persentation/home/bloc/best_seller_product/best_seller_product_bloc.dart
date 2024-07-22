// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter_onlineshop_app/data/datasources/product_remote_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/responses/product_response_model.dart';

part 'best_seller_product_bloc.freezed.dart';
part 'best_seller_product_event.dart';
part 'best_seller_product_state.dart';

class BestSellerProductBloc
    extends Bloc<BestSellerProductEvent, BestSellerProductState> {
  final ProductRemoteDatasource _productRemoteDatasource;
  BestSellerProductBloc(
    this._productRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GetBestSellerProducts>((event, emit) async {
      emit(const BestSellerProductState.loading());
      final response = await _productRemoteDatasource
          .getProductByCategory(13); //get product by category9
      response.fold(
        (l) =>
            emit(const BestSellerProductState.error('Internal Server Error')),
        (r) => emit(BestSellerProductState.loaded(r.data!.data!)),
      );
    });
  }
}
