import 'package:borlago/base/di/get_it.dart';
import 'package:borlago/feature_authentication/providers/authentication_provider.dart';
import 'package:borlago/feature_user/domain/models/user.dart';
import 'package:borlago/feature_user/domain/models/user_location.dart';
import 'package:borlago/feature_user/domain/use_cases/user_use_cases.dart';
import 'package:flutter/cupertino.dart';

class UserViewModel {
  final userUseCases = getIt<UserUseCases>();
  final authProvider = getIt<AuthenticationProvider>();

  Future<User?> updateUser({
    required String email,
    String? firstName,
    String? lastName,
    String? phone,
    String? gender,
    String? country,
  }) async {
    User? user;
    try {
      user = await userUseCases.updateUser(
        jwt: authProvider.jwt!,
        email: email,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        gender: gender,
        country: country
      );
    } catch(error) {
      debugPrint("User view model update user error: $error");
    }
    return user;
  }

  Future<UserLocation?> addLocation({
    required double longitude,
    required double latitude,
    required String name,
  }) async {
    UserLocation? location;
    try {
      location = await userUseCases.addLocation(
          jwt: authProvider.jwt!,
          longitude: longitude,
          latitude: latitude,
          name: name
      );
    } catch(error) {
      debugPrint("User view model get addLocation error: $error");
    }
    return location;
  }

  Future<List<UserLocation?>?> getUserLocations() async {
    List<UserLocation?>? locations;
    try {
      locations = await userUseCases.getUserLocations(jwt: authProvider.jwt!);
    } catch(error) {
      debugPrint("User view model getUserLocations error: $error");
    }

    return locations;
  }

  Future<bool> deleteLocation({required String locationId}) async {
    bool success = false;

    try {
      success = await userUseCases.deleteLocation(
        jwt: authProvider.jwt!,
        locationId: locationId
      );
    } catch(error) {
      debugPrint("User view model deleteLocation error: $error");
    }

    return success;
  }

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
}) async {
    bool success = false;
    try {
      String? response = await userUseCases.changePassword(
        jwt: authProvider.jwt!,
        currentPassword: currentPassword,
        newPassword: newPassword
      );

      if(response != null) {
        success = true;
      }
    } catch(error) {
      debugPrint("User view model change password error: $error");
    }
    return success;
  }
}