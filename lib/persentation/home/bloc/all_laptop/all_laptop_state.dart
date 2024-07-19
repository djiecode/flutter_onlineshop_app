part of 'all_laptop_bloc.dart';

@freezed
class AllLaptopState with _$AllLaptopState {
  const factory AllLaptopState.initial() = _Initial;
    const factory AllLaptopState.loading() = _Loading;
  const factory AllLaptopState.loaded(List<Product> products) = _Loaded;
  const factory AllLaptopState.error(String message) = _Error;
  
}
