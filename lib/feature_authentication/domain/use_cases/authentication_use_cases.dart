import 'package:borlago/base/di/get_it.dart';
import 'package:borlago/feature_authentication/domain/models/login.dart';
import 'package:borlago/feature_authentication/domain/repository/auth_repo.dart';
import 'package:borlago/base/utils/constants.dart';

class AuthenticationUseCases {
  Future<Login?> login({
    required String email,
    required String password
  }) async {
    Map<String, dynamic> body = {
      "email": email,
      "password": password,
      "user_type": Constants.userType
    };

    return getIt.get<AuthenticationRepository>().login(body);
  }

  Future<Login?> register({
    required String email,
    required String firstName,
    required String lastName,
    required String gender,
    required String country,
    required String phone,
    required String password
  }) async {

    Map<String, dynamic> body = {
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      "gender": gender,
      "country": country,
      "phone": phone,
      "password": password,
      "user_type": Constants.userType
    };

    return getIt.get<AuthenticationRepository>().register(body);
  }
}