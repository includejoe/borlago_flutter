import 'package:borlago/base/di/locator.dart';
import 'package:borlago/feature_authentication/domain/models/Register.dart';
import 'package:borlago/feature_authentication/domain/models/login.dart';
import 'package:borlago/feature_authentication/domain/repository/auth_repo.dart';
import 'package:borlago/base/utils/constants.dart';

class AuthenticationUseCases {
  Future<LoginResponse?> login({
    required email,
    required password
  }) async {
    Login loginBody = Login(
      email: email,
      password: password,
      userType: Constants.userType
    );

    return locator.get<AuthenticationRepository>().login(loginBody);
  }

  Future<Register?> register({
    required email,
    required firstName,
    required lastName,
    required gender,
    required country,
    required phone,
    required password
  }) async {
    Register registerBody = Register(
      email: email,
      firstName: firstName,
      lastName: lastName,
      gender: gender,
      country: country,
      phone: phone,
      password: password,
      userType: Constants.userType
    );

    return locator.get<AuthenticationRepository>().register(registerBody);
  }
}