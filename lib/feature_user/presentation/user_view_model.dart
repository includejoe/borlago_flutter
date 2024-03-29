import 'package:borlago/base/di/get_it.dart';
import 'package:borlago/feature_authentication/providers/authentication_provider.dart';
import 'package:borlago/feature_user/domain/models/payment_method.dart';
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

  Future<PaymentMethod?> addPaymentMethod({
    required String type,
    required String name,
    required String accountNumber,
    String? nameOnCard,
    String? expiryDate,
    String? securityCode,
    String? zipCode,
  }) async {
    PaymentMethod? paymentMethod;
    try {
      paymentMethod = await userUseCases.addPaymentMethod(
        jwt: authProvider.jwt!,
        type: type,
        name: name,
        accountNumber: accountNumber,
        nameOnCard: nameOnCard,
        expiryDate: expiryDate,
        securityCode: securityCode,
        zipCode: zipCode
      );
    } catch(error) {
      debugPrint("User view model addPaymentMethod error: $error");
    }
    return paymentMethod;
  }

  Future<PaymentMethod?> updatePaymentMethod({
    required String paymentMethodId,
    String? type,
    String? name,
    String? accountNumber,
    String? nameOnCard,
    String? expiryDate,
    String? securityCode,
    String? zipCode,
  }) async {
    PaymentMethod? paymentMethod;
    try {
      paymentMethod = await userUseCases.updatePaymentMethod(
          jwt: authProvider.jwt!,
          paymentMethodId: paymentMethodId,
          type: type,
          name: name,
          accountNumber: accountNumber,
          nameOnCard: nameOnCard,
          expiryDate: expiryDate,
          securityCode: securityCode,
          zipCode: zipCode
      );
    } catch(error) {
      debugPrint("User view model updatePaymentMethod error: $error");
    }
    return paymentMethod;
  }

  Future<List<PaymentMethod?>?> getPaymentMethods() async {
    List<PaymentMethod?>? paymentMethods;
    try {
      paymentMethods = await userUseCases.getPaymentMethods(jwt: authProvider.jwt!);
    } catch(error) {
      debugPrint("User view model getPaymentMethods error: $error");
    }
    return paymentMethods;
  }

  Future<bool> deletePaymentMethod({required String paymentMethodId}) async {
    bool success = false;
    try {
      success = await userUseCases.deletePaymentMethod(
        jwt: authProvider.jwt!,
        paymentMethodId: paymentMethodId
      );
    } catch(error) {
      debugPrint("User view model deletePaymentMethod error: $error");
    }
    return success;
  }


  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    bool success = false;
    try {
      success = await userUseCases.changePassword(
        jwt: authProvider.jwt!,
        currentPassword: currentPassword,
        newPassword: newPassword
      );
    } catch(error) {
      debugPrint("User view model change password error: $error");
    }
    return success;
  }
}