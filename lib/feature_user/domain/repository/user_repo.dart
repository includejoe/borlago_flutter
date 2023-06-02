import 'package:borlago/feature_user/domain/models/User.dart';

abstract class UserRepository {
  Future<User?> getUser({required String jwt, required String email});
}