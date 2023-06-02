import 'dart:convert';
import 'package:borlago/feature_authentication/domain/models/Register.dart';
import 'package:borlago/feature_authentication/domain/models/login.dart';
import 'package:borlago/feature_authentication/domain/repository/auth_repo.dart';
import 'package:borlago/base/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  @override
  Future<LoginResponse?> login(Login body) async {
    var uri = Uri.parse("${Constants.borlaGoBaseUrl}/authentication/login/");
    LoginResponse? loginResponse;

    await http.post(uri, body: body)
    .then((response) {
      Map<String, dynamic> responseJson = jsonDecode(response.body);
      loginResponse = LoginResponse.fromJson(responseJson);
    })
    .catchError((error) {
      if (kDebugMode) {
        print("The error is: $error");
      }
    });

    return loginResponse;
  }

  @override
  Future<Register?> register(Register body) async {
    var uri = Uri.parse("${Constants.borlaGoBaseUrl}/authentication/register/");
    Register? registerResponse;

    await http.post(uri, body: body)
    .then((response) {
      Map<String, dynamic> responseJson = jsonDecode(response.body);
      registerResponse = Register.fromJson(responseJson);
    })
    .catchError((error) {
      if (kDebugMode) {
        print("The error is: $error");
      }
    });

    return registerResponse;

  }

}