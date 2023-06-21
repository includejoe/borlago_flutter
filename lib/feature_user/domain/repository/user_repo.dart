import 'package:borlago/feature_user/domain/models/Payment.dart';
import 'package:borlago/feature_user/domain/models/payment_method.dart';
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

  Future<PaymentMethod?> addPaymentMethod({
    required String jwt,
    required Map<String, dynamic> body
  });

  Future<PaymentMethod?> updatePaymentMethod({
    required String jwt,
    required String paymentMethodId,
    required Map<String, dynamic> body
  });

  Future<List<PaymentMethod?>?> getPaymentMethods({
    required String jwt,
  });

  Future<bool> deletePaymentMethod({
    required String jwt,
    required String paymentMethodId
  });

  Future<List<Payment?>?> getPaymentHistory({
    required String jwt,
  });

  Future<bool> changePassword({
    required String jwt,
    required Map<String, dynamic> body
  });

}