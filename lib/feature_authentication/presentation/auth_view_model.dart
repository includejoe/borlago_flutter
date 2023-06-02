import 'package:borlago/base/di/get_it.dart';
import 'package:borlago/feature_authentication/domain/models/login.dart';
import 'package:borlago/feature_authentication/domain/use_cases/authentication_use_cases.dart';
import 'package:borlago/feature_authentication/providers/authentication_provider.dart';
import 'package:borlago/feature_user/domain/models/User.dart';
import 'package:borlago/feature_user/domain/use_cases/user_use_cases.dart';
import 'package:flutter/foundation.dart';

class AuthenticationViewModel {
  final authUseCases = getIt<AuthenticationUseCases>();
  final userUseCases = getIt<UserUseCases>();
  final authProvider = getIt<AuthenticationProvider>();

  Future<bool> login({required String email, required String password}) async {
    bool success = false;

    try {
      Login? loginResponse = await authUseCases.login(
        email: email,
        password: password
      );

      if (loginResponse != null) {
        User? user = await userUseCases.getUser(
          jwt: loginResponse.jwt,
          email: loginResponse.email
        );

        if (user != null) {
          authProvider.login(jwt: loginResponse.jwt, user: user);
          success = true;
        }
      }
    } catch(error) {
      if (kDebugMode) {
        print("Login viewModel error: $error");
      }
    }

    return success;
  }

  Future<bool> register({
    required String firstName,
    required String lastName,
    required String email,
    required String gender,
    required String phone,
    required String country,
    required String password,
  }) async {
    bool success = false;

    try {
      Login? registerResponse = await authUseCases.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        gender: gender,
        phone: phone,
        country: country,
        password: password
      );

      if (registerResponse != null) {
        User? user = await userUseCases.getUser(
            jwt: registerResponse.jwt,
            email: registerResponse.email
        );

        if (user != null) {
          authProvider.login(jwt: registerResponse.jwt, user: user);
          success = true;
        }
      }
    } catch(error) {
      if (kDebugMode) {
        print("Register viewModel error: $error");
      }
    }

    return success;
  }

}