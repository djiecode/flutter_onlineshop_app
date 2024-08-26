
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_onlineshop_app/data/datasources/auth_remote_datasource.dart';
// import 'package:flutter_onlineshop_app/data/models/responses/auth_response_model.dart';


// //--Bloc
// //=============================================================================


// //--validation for text field
// String validateLogin(GetSignin data) {
//   if (data.email?.isEmpty == true) {
//     return 'Please Enter Your Email ID';
//   }
//   if (data.password?.isEmpty == true) {
//     return 'Please Enter Your Password';
//   }
//   return '';
// }

// //--BlocEvent
// //=============================================================================
// sealed class AuthEvent {}

// class GetSignin extends AuthEvent {
//   final String? email;
//   final String? password;
//   GetSignin({required this.email, required this.password});
// }

// class GetSignout extends AuthEvent {}

// //--BlocState
// //=============================================================================
// sealed class AuthState {}

// final class AuthInitialState extends AuthState {}

// class SigninValidation extends AuthState {
//   final String? value;
//   SigninValidation(this.value);
// }

// final class AuthLoadingState extends AuthState {}

// final class AuthErrorState extends AuthState {
//   final String? error;
//   AuthErrorState(this.error);
// }

// final class AuthSignedUpState extends AuthState {
//   final AuthResponseModel dataOutput;
//   AuthSignedUpState({required this.dataOutput});
// }

// final class AuthSignedInState extends AuthState {
//   final AuthResponseModel dataOutput;

//   AuthSignedInState(this.dataOutput);
// }

// final class AuthSignedOutState extends AuthState {}
