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
    Login? response;
    String jsonBody = json.encode(body);

    await http.post(
      uri,
      body: jsonBody,
      headers: {
        "Content-Type": "application/json"
      }
    )
    .then((data) {
      Map<String, dynamic> dataJson = jsonDecode(data.body);
      response = Login.fromJson(dataJson);
    })
    .catchError((error) {
      debugPrint("Authentication repository login error: ${error.toString()}");
    });

    return response;
  }

  @override
  Future<Login?> register(Map<String, dynamic> body) async {
    var uri = Uri.parse("${Constants.borlaGoBaseUrl}/auth/register/");
    Login? response;
    String jsonBody = json.encode(body);

    await http.post(
      uri,
      body: jsonBody,
      headers: {
        "Content-Type": "application/json"
      }
    )
    .then((data) {
      Map<String, dynamic> dataJson = jsonDecode(data.body);
      response = Login.fromJson(dataJson);
    })
    .catchError((error) {
      debugPrint("Authentication repository register error: ${error.toString()}");
    });
    return response;
  }
}