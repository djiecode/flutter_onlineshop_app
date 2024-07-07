// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_onlineshop_app/data/datasources/auth_remote_datasource.dart';


part 'login_bloc.freezed.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRemoteDatasource authRemoteDataSource;
  LoginBloc(
    this.authRemoteDataSource,
  ) : super(const _Initial()) {
    on<_Login>((event, emit) async{
      emit(const _Loading());
      final response = await authRemoteDataSource.login(event.email, event.password);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
