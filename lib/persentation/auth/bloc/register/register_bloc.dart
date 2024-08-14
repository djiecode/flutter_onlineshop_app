import 'package:bloc/bloc.dart';
import 'package:flutter_onlineshop_app/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_onlineshop_app/data/models/requests/register_request.dart';
import 'package:flutter_onlineshop_app/data/models/responses/auth_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_bloc.freezed.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(AuthRemoteDatasource authRemoteDatasource) : super(const _Initial()) {
    on<_Register>((event, emit) async {
      emit(const _Loading());
      try {
        final result = await AuthRemoteDatasource().register(event.model);
        result.fold(
          (error) => emit(_Error(error)),
          (data) => emit(_Loaded(data)),
        );
      } catch (e) {
        emit(_Error(e.toString()));
      }
    });
  }
}
