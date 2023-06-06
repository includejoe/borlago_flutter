import 'dart:convert';
import 'package:borlago/base/utils/constants.dart';
import 'package:borlago/feature_user/domain/models/user.dart';
import 'package:borlago/feature_user/domain/repository/user_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class UserRepositoryImpl extends UserRepository {
  @override
  Future<User?> getUser({required String jwt, required String email}) async {
    var uri = Uri.parse("${Constants.borlaGoBaseUrl}/user/detail/$email/");
    User? response;

    await http.get(uri, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwt"
    }).then((data) {
      Map<String, dynamic> dataJson = jsonDecode(data.body) ;
      response = User.fromJson(dataJson);
    }).catchError((error) {
      debugPrint("User repository getUser error: $error");
    });

    return response;
  }

  @override
  Future<User?> updateUser({
    required String jwt,
    required String email,
    required Map<String, dynamic> body
  }) async {
    var uri = Uri.parse("${Constants.borlaGoBaseUrl}/user/detail/$email/");
    User? response;
    String jsonBody = json.encode(body);

    await http.patch(
      uri,
      body: jsonBody,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $jwt"
      }
    ).then((data) {
      Map<String, dynamic> dataJson = jsonDecode(data.body);
      response = User.fromJson(dataJson);
    }).catchError((error) {
      debugPrint("User repository updateUser error: ${error.toString()}");
    });

    return response;
  }

  @override
  Future<String?> changePassword({
    required String jwt,
    required Map<String, dynamic> body
  }) async {
    var uri = Uri.parse("${Constants.borlaGoBaseUrl}/user/password/change/");
    String? response;
    String jsonBody = json.encode(body);
    
    await http.patch(
      uri,
      body: jsonBody,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $jwt"
      }
    ).then((data) {
      Map<String, dynamic> dataJson = jsonDecode(data.body);
      response = dataJson["detail"];
    }).catchError((error) {
      debugPrint("User repository changeUser error: $error");
    });
    
    return response;
  }
}