import 'package:borlago/feature_user/domain/models/user.dart';
import 'package:borlago/feature_user/domain/models/user_location.dart';

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

  Future<UserLocation?> addLocation({
    required String jwt,
    required Map<String, dynamic> body
  });

  Future<List<UserLocation?>?> getUserLocations({
    required String jwt,
  });

  Future<bool> deleteLocation({
    required String jwt,
    required String locationId
  });

  Future<String?> changePassword({
    required String jwt,
    required Map<String, dynamic> body
  });

}