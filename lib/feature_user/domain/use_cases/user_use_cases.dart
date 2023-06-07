import 'package:borlago/base/di/get_it.dart';
import 'package:borlago/feature_user/domain/models/user.dart';
import 'package:borlago/feature_user/domain/models/user_location.dart';
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

  Future<UserLocation?> addLocation({
    required String jwt,
    required double longitude,
    required double latitude,
    required String name,
  }) async {
    Map<String, dynamic> body = {
      "longitude": longitude,
      "latitude": latitude,
      "name": name,
    };

    return getIt<UserRepository>().addLocation(
      jwt: jwt,
      body: body
    );
  }

  Future<List<UserLocation?>?> getUserLocations({
    required String jwt,
  }) async {
    return getIt<UserRepository>().getUserLocations(jwt: jwt);
  }

  Future<bool> deleteLocation({
    required String jwt,
    required String locationId,
  }) async {
    return getIt<UserRepository>().deleteLocation(
      jwt: jwt,
      locationId: locationId
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

