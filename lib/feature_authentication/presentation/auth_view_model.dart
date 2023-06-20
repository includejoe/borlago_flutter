import 'package:borlago/base/di/get_it.dart';
import 'package:borlago/feature_authentication/domain/models/login.dart';
import 'package:borlago/feature_authentication/domain/use_cases/authentication_use_cases.dart';
import 'package:borlago/feature_authentication/providers/authentication_provider.dart';
import 'package:borlago/feature_user/domain/models/user.dart';
import 'package:borlago/feature_user/domain/use_cases/user_use_cases.dart';
import 'package:flutter/foundation.dart';

class AuthenticationViewModel {
  final authUseCases = getIt<AuthenticationUseCases>();
  final userUseCases = getIt<UserUseCases>();
  final authProvider = getIt<AuthenticationProvider>();

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
      Login? response = await authUseCases.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        gender: gender,
        phone: phone,
        country: country,
        password: password
      );

      if (response != null) {
        User? user = await userUseCases.getUser(
            jwt: response.jwt,
            email: response.email
        );

        if (user != null) {
          authProvider.login(jwt: response.jwt, user: user);
          success = true;
        }
      }
    } catch(error) {
      debugPrint("Authentication view model register error: $error");
    }

    return success;
  }

  Future<bool> login({required String email, required String password}) async {
    bool success = false;

    try {
      Login? response = await authUseCases.login(
          email: email,
          password: password
      );

      if (response != null) {
        User? user = await userUseCases.getUser(
            jwt: response.jwt,
            email: response.email
        );

        if (user != null) {
          authProvider.login(jwt: response.jwt, user: user);
          success = true;
        }
      }
    } catch(error) {
      debugPrint("Authentication view model login error: $error");
    }

    return success;
  }

  Future<bool> forgotPassword({required String email}) async {
    bool success = false;
    try {
      success = await authUseCases.forgotPassword(email: email);
    } catch(error) {
      debugPrint("Authentication view model forgotPassword error: $error");
    }
    return success;
  }

  Future<bool> resetPassword({
    required String email,
    required String resetCode,
    required String newPassword
  }) async {
    bool success = false;
    try {
      success = await authUseCases.resetPassword(
        email: email,
        resetCode: resetCode,
        newPassword: newPassword
      );
    } catch(error) {
      debugPrint("Authentication view model resetPassword error: $error");
    }
    return success;
  }

}