import 'package:borlago/base/di/get_it.dart';
import 'package:borlago/feature_user/domain/models/User.dart';
import 'package:borlago/feature_user/domain/repository/user_repo.dart';

class UserUseCases {
  Future<User?> getUser({
    required String jwt,
    required String email
  }) async {
    return getIt.get<UserRepository>().getUser(jwt: jwt, email: email);
  }
}