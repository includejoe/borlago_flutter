import 'package:borlago/feature_user/domain/models/user.dart';

abstract class UserRepository {
  Future<User?> getUser({
    required String jwt,
    required String email
  });

  Future<User?> updateUser({
    required String jwt,
    required String email,
    required Map<String, dynamic> body
  });

  Future<String?> changePassword({
    required String jwt,
    required Map<String, dynamic> body
  });

}