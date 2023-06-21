import 'package:borlago/base/di/get_it.dart';
import 'package:borlago/feature_user/domain/models/Payment.dart';
import 'package:borlago/feature_user/domain/models/payment_method.dart';
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

  Future<PaymentMethod?> addPaymentMethod({
    required String jwt,
    required String type,
    required String name,
    required String accountNumber,
    String? nameOnCard,
    String? expiryDate,
    String? securityCode,
    String? zipCode,
  }) async {
    Map<String, dynamic> body = {
      "type": type,
      "name": name,
      "account_number": accountNumber,
      "name_on_card": nameOnCard,
      "expiry_date": expiryDate,
      "security_code": securityCode,
      "zip_code": zipCode,
    };

    return getIt<UserRepository>().addPaymentMethod(
      jwt: jwt,
      body: body
    );
  }

  Future<PaymentMethod?> updatePaymentMethod({
    required String jwt,
    required String paymentMethodId,
    String? type,
    String? name,
    String? accountNumber,
    String? nameOnCard,
    String? expiryDate,
    String? securityCode,
    String? zipCode,
  }) async {
    Map<String, dynamic> body = {
      "type": type,
      "name": name,
      "account_number": accountNumber,
      "name_on_card": nameOnCard,
      "expiry_date": expiryDate,
      "security_code": securityCode,
      "zip_code": zipCode,
    };

    return getIt<UserRepository>().updatePaymentMethod(
        jwt: jwt,
        paymentMethodId: paymentMethodId,
        body: body
    );
  }

  Future<List<PaymentMethod?>?> getPaymentMethods({
    required String jwt,
  }) async {
    return getIt<UserRepository>().getPaymentMethods(jwt: jwt);
  }

  Future<bool> deletePaymentMethod({
    required String jwt,
    required String paymentMethodId,
  }) async {
    return getIt<UserRepository>().deletePaymentMethod(
      jwt: jwt,
      paymentMethodId: paymentMethodId
    );
  }

  Future<List<Payment?>?> getPaymentHistory({
    required String jwt,
  }) async {
    return getIt<UserRepository>().getPaymentHistory(jwt: jwt);
  }

  Future<bool> changePassword({
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

