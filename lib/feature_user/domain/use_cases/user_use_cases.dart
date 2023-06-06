import 'package:borlago/base/di/get_it.dart';
import 'package:borlago/feature_user/domain/models/user.dart';
import 'package:borlago/feature_user/domain/repository/user_repo.dart';

class UserUseCases {
  Future<User?> getUser({
    required String jwt,
    required String email
  }) async {
    return getIt.get<UserRepository>().getUser(
      jwt: jwt,
      email: email
    );
  }

  Future<User?> updateUser({
    required String jwt,
    required String email,
    String? firstName,
    String? lastName,
    String? phone,
    String? gender,
    String? country,
  }) async {
    Map<String, dynamic> body = {
      "first_name": firstName,
      "last_name": lastName,
      "phone": phone,
      "gender": gender,
      "country": country,
    };

    return getIt<UserRepository>().updateUser(
      jwt: jwt,
      email: email,
      body: body
    );
  }

  Future<String?> changePassword({
    required String jwt,
    required String currentPassword,
    required String newPassword,
  }) async {
    Map<String, dynamic> body = {
      "current_password": currentPassword,
      "new_password": newPassword,
    };

    return getIt<UserRepository>().changePassword(
        jwt: jwt,
        body: body
    );
  }
}

