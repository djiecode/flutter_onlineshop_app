// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';

import 'package:flutter_onlineshop_app/data/datasources/product_remote_datasource.dart';

import 'package:flutter_onlineshop_app/data/models/responses/product_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';



part 'special_offer_product_bloc.freezed.dart';
part 'special_offer_product_event.dart';
part 'special_offer_product_state.dart';

class SpecialOfferProductBloc
    extends Bloc<SpecialOfferProductEvent, SpecialOfferProductState> {
  final ProductRemoteDatasource _productRemoteDatasource;
  SpecialOfferProductBloc(
    this._productRemoteDatasource,
  ) : super(const _Initial()) {
    on<SpecialOfferProductEvent>((event, emit) async {
      emit(const SpecialOfferProductState.loading());
      final response = await _productRemoteDatasource
          .getFeature(12);  //;get product by category10
      response.fold(
        (l) =>
            emit(const SpecialOfferProductState.error('Internal Server Error')),
        (r) => emit(SpecialOfferProductState.loaded(r.data!.data!)),
      );
    });
  }
}
