import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_onlineshop_app/core/constants/variables.dart';
import 'package:flutter_onlineshop_app/data/models/requests/register_request.dart';

import '../models/responses/auth_response_model.dart';
import 'package:http/http.dart' as http;

import 'auth_local_datasource.dart';

class AuthRemoteDatasource {
  // login
  Future<Either<String, AuthResponseModel>> login(
      String email, String password ) async {
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/login'),
      body: {
        'email': email,
        'password': password,
      },
    );
    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    }
    return Left(response.body);
  }
    // register
  // Future<Either<String, AuthResponseModel>> register(
  //     RegisterRequest model) async {
  //   final headers = {
  //     'Accept': 'application/json',
  //     'Content-Type': 'application/json'
  //   };
  //   final response = await http.post(
  //       Uri.parse('${Variables.baseUrl}/api/register'),
  //       headers: headers,
  //       body: model.toJson());

  //   if (response.statusCode == 200) {
  //     return Right(AuthResponseModel.fromJson(response.body));
  //   } else {
  //     return const Left('Server error');
  //   }
  // }
// register
Future<Either<String, AuthResponseModel>> register(
    RegisterRequest model) async {
  final headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json'
  };

  final body = jsonEncode(model.toJson());

  final response = await http.post(
    Uri.parse('${Variables.baseUrl}/api/register'),
    headers: headers,
    body: body,
  );

  // print('Request sent: ${response.request}');
  // print('Status code: ${response.statusCode}');
  // print('Response body: ${response.body}');

  if (response.statusCode == 201) {
    return Right(AuthResponseModel.fromJson(response.body));
  } else {
    return const Left('Server error');
  }
}



// logout
  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
        Uri.parse('${Variables.baseUrl}/api/logout'),
        headers: {'Authorization': 'Bearer ${authData?.accessToken}'});

    if (response.statusCode == 200) {
      AuthLocalDatasource().removeAuthData();
      return Right(response.body);
    } else {
      return Left(response.body);
    }
  }

    //update fcm token
  Future<Either<String, String>> updateFcmToken(String fcmToken) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/update-fcm'),
      headers: {
        'Authorization': 'Bearer ${authData?.accessToken}',
        'Accept': 'application/json',
      },
      body: {'fcm_id': fcmToken},
    );

    if (response.statusCode == 200) {
      return Right(response.body);
    } else {
      return Left(response.body);
    }
  }
}
