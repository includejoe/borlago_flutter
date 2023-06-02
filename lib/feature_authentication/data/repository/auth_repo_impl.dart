import 'dart:convert';
import 'package:borlago/feature_authentication/domain/models/login.dart';
import 'package:borlago/feature_authentication/domain/repository/auth_repo.dart';
import 'package:borlago/base/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  @override
  Future<Login?> login(Map<String, dynamic> body) async {
    var uri = Uri.parse("${Constants.borlaGoBaseUrl}/auth/login/");
    Login? loginResponse;
    String jsonBody = json.encode(body);

    await http.post(
      uri,
      body: jsonBody,
      headers: {
        "Content-Type": "application/json"
      }
    )
    .then((response) {
      Map<String, dynamic> responseJson = jsonDecode(response.body);
      loginResponse = Login.fromJson(responseJson);
    })
    .catchError((error) {
      if (kDebugMode) {
        print("Repository error is: $error");
      }
    });

    return loginResponse;
  }

  @override
  Future<Login?> register(Map<String, dynamic> body) async {
    var uri = Uri.parse("${Constants.borlaGoBaseUrl}/auth/register/");
    Login? registerResponse;
    String jsonBody = json.encode(body);

    await http.post(
      uri,
      body: jsonBody,
      headers: {
        "Content-Type": "application/json"
      }
    )
    .then((response) {
      Map<String, dynamic> responseJson = jsonDecode(response.body);
      registerResponse = Login.fromJson(responseJson);
    })
    .catchError((error) {
      if (kDebugMode) {
        print("Repository error is: ${error.toString()}");
      }
    });
    return registerResponse;
  }

}