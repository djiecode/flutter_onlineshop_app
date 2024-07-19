import 'package:bloc/bloc.dart';
import 'package:flutter_onlineshop_app/data/datasources/product_remote_datasource.dart';
import 'package:flutter_onlineshop_app/data/models/responses/product_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'all_laptop_event.dart';
part 'all_laptop_state.dart';
part 'all_laptop_bloc.freezed.dart';

class AllLaptopBloc extends Bloc<AllLaptopEvent, AllLaptopState> {
  final ProductRemoteDatasource _productRemoteDatasource;
  AllLaptopBloc(
    this._productRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GetByCategory>((event, emit) async {
      emit(const _Loading());
      final response = await _productRemoteDatasource.getProductByCategory(event.categoryId);
      response.fold(
        (l) => emit(const AllLaptopState.error('Internal Server Error')),
        (r) => emit(AllLaptopState.loaded(r.data!.data!)),
      );
    });
  }
}
