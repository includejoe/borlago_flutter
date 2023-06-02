import 'package:borlago/base/di/locator.dart';
import 'package:borlago/feature_authentication/domain/use_cases/authentication_use_cases.dart';

class LoginViewModel {
  final authUseCases = locator<AuthenticationUseCases>();

  Future<bool> login(String email, String password) async {
    bool success = false;
    authUseCases.login(email: email, password: password)
      .then((response) {
        if(response != null) {
          success = true;
        }
      });

    return success;
  }

}