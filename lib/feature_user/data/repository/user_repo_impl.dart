import 'dart:convert';
import 'package:borlago/base/utils/constants.dart';
import 'package:borlago/feature_user/domain/models/User.dart';
import 'package:borlago/feature_user/domain/repository/user_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class UserRepositoryImpl extends UserRepository {
  @override
  Future<User?> getUser({required String jwt, required String email}) async {
    var uri = Uri.parse("${Constants.borlaGoBaseUrl}/user/detail/$email/");
    User? user;

    await http.get(uri, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwt"
    }).then((response) {
      Map<String, dynamic> responseJson = jsonDecode(response.body) ;
      user = User.fromJson(responseJson);
    }).catchError((error) {
      if (kDebugMode) {
        print("The error is: $error");
      }
    });

    return user;
  }
}