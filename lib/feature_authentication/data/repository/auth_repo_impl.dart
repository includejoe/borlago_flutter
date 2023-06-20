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
    ).then((data) {
      Map<String, dynamic> dataJson = jsonDecode(data.body);
      response = Login.fromJson(dataJson);
    }).catchError((error) {
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
    ).then((data) {
      Map<String, dynamic> dataJson = jsonDecode(data.body);
      response = Login.fromJson(dataJson);
    }).catchError((error) {
      debugPrint("Authentication repository register error: ${error.toString()}");
    });
    return response;
  }

  @override
  Future<bool> forgotPassword(Map<String, dynamic> body) async {
    var uri = Uri.parse("${Constants.borlaGoBaseUrl}/auth/forgot-password/");
    bool success = false;
    String jsonBody = json.encode(body);

    await http.post(
        uri,
        body: jsonBody,
        headers: {
          "Content-Type": "application/json"
        }
    ).then((_) {
      success = true;
    }).catchError((error) {
      debugPrint("Authentication repository forgotPassword error: ${error.toString()}");
    });

    return success;
  }

  @override
  Future<bool> resetPassword(Map<String, dynamic> body) async {
    var uri = Uri.parse("${Constants.borlaGoBaseUrl}/auth/reset-password/");
    bool success = false;
    String jsonBody = json.encode(body);

    await http.patch(
        uri,
        body: jsonBody,
        headers: {
          "Content-Type": "application/json"
        }
    ).then((response) {
      if(response.statusCode >= 200 && response.statusCode < 400) {
        success = true;
      }
    }).catchError((error) {
      debugPrint("Authentication repository resetPassword error: ${error.toString()}");
    });

    return success;
  }
}