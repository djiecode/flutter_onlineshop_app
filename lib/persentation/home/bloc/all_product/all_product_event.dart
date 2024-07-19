part of 'all_product_bloc.dart';

@freezed
class AllProductEvent with _$AllProductEvent {
  const factory AllProductEvent.started() = _Started;
  const factory AllProductEvent.getAllProducts() = _GetAllProducts;
  // const factory AllProductEvent.getByCategory(int categoryId) = _GetByCategory;
}