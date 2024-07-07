import 'package:flutter_onlineshop_app/data/models/responses/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasource {
  Future<void> saveAuthData(AuthResponseModel authResponseModel) async {
    // Save auth data to local storage
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_data', authResponseModel.toJson());
  }

  Future<void> removeAuthData() async {
    // Remove auth data from local storage
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_data');
  }

  Future<AuthResponseModel?> getAuthData() async {
    // Get auth data from local storage
    final prefs = await SharedPreferences.getInstance();
    final authData = prefs.getString('auth_data');
    if (authData != null) {
      return AuthResponseModel.fromJson(authData);
    }
    return null;
  }

  Future<bool> isAuth() async {
    // Check if user is authenticated
    final prefs = await SharedPreferences.getInstance();
    final authData = prefs.getString('auth_data');
    if (authData != null) {
      return true;
    }else{
      return false;
    }
  }
}
