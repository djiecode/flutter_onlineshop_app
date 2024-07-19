part of 'all_laptop_bloc.dart';

@freezed
class AllLaptopEvent with _$AllLaptopEvent {
  const factory AllLaptopEvent.started() = _Started;
  const factory AllLaptopEvent.getAllProducts() = _GetAllLaptops;
  const factory AllLaptopEvent.getByCategory(int categoryId) = _GetByCategory;
}
