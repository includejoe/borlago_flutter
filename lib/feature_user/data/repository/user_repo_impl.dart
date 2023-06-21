import 'dart:convert';
import 'package:borlago/base/utils/constants.dart';
import 'package:borlago/feature_user/domain/models/Payment.dart';
import 'package:borlago/feature_user/domain/models/payment_method.dart';
import 'package:borlago/feature_user/domain/models/user.dart';
import 'package:borlago/feature_user/domain/models/user_location.dart';
import 'package:borlago/feature_user/domain/repository/user_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class UserRepositoryImpl extends UserRepository {
  @override
  Future<User?> getUser({required String jwt, required String email}) async {
    var uri = Uri.parse("${Constants.borlaGoBaseUrl}/user/detail/$email/");
    User? response;

    await http.get(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $jwt"
      }
    ).then((httpResponse) {
      if(httpResponse.statusCode >= 200 && httpResponse.statusCode < 400) {
        Map<String, dynamic> dataJson = jsonDecode(httpResponse.body);
        response = User.fromJson(dataJson);
      } else {
        debugPrint(httpResponse.body);
      }
    }).catchError((error) {
      debugPrint("User repository getUser error: $error");
    });

    return response;
  }

  @override
  Future<User?> updateUser({
    required String jwt,
    required String email,
    required Map<String, dynamic> body
  }) async {
    var uri = Uri.parse("${Constants.borlaGoBaseUrl}/user/detail/$email/");
    User? response;
    String jsonBody = json.encode(body);

    await http.patch(
      uri,
      body: jsonBody,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $jwt"
      }
    ).then((httpResponse) {
      if(httpResponse.statusCode >= 200 && httpResponse.statusCode < 400) {
        Map<String, dynamic> dataJson = jsonDecode(httpResponse.body);
        response = User.fromJson(dataJson);
      } else {
        debugPrint(httpResponse.body);
      }
    }).catchError((error) {
      debugPrint("User repository updateUser error: ${error.toString()}");
    });

    return response;
  }

  @override
  Future<UserLocation?> addLocation({
    required String jwt,
    required Map<String, dynamic> body
  }) async {
    var uri = Uri.parse("${Constants.borlaGoBaseUrl}/user/location/add/");
    UserLocation? response;
    String jsonBody = json.encode(body);

    await http.post(
      uri,
      body: jsonBody,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $jwt"
      }
    ).then((httpResponse) {
      if(httpResponse.statusCode >= 200 && httpResponse.statusCode < 400) {
        Map<String, dynamic> dataJson = jsonDecode(httpResponse.body);
        response = UserLocation.fromJson(dataJson);
      } else {
        debugPrint(httpResponse.body);
      }
    }).catchError((error) {
      debugPrint("User repository addLocation error: $error");
    });

    return response;
  }

  @override
  Future<List<UserLocation?>?> getUserLocations({required String jwt}) async {
    var uri = Uri.parse("${Constants.borlaGoBaseUrl}/user/location/all/");
    List<UserLocation?>? response;

    await http.get(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $jwt"
      }
    ).then((httpResponse) {
      if(httpResponse.statusCode >= 200 && httpResponse.statusCode < 400) {
        List<dynamic> dataList = jsonDecode(httpResponse.body);
        response = dataList.map((location) => UserLocation.fromJson(location))
            .toList();
      } else {
        debugPrint(httpResponse.body);
      }
    }).catchError((error) {
      debugPrint("User repository getUserLocations error: $error");
    });

    return response;
  }

  @override
  Future<bool> deleteLocation({
    required String jwt,
    required String locationId
  }) async {
    bool success = false;
    var uri = Uri.parse("${Constants.borlaGoBaseUrl}/user/location/delete/$locationId/");
    await http.delete(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwt"
        }
    ).then((httpResponse) {
      if(httpResponse.statusCode >= 200 && httpResponse.statusCode < 400) {
        success = true;
      } else {
        debugPrint(httpResponse.body);
      }
    }).catchError((error) {
      debugPrint("User repository getUserLocations error: $error");
    });

    return success;
  }


  @override
  Future<PaymentMethod?> addPaymentMethod({
    required String jwt,
    required Map<String, dynamic> body
  }) async {
      var uri = Uri.parse("${Constants.borlaGoBaseUrl}/user/payment-method/add/");
      PaymentMethod? response;
      String jsonBody = json.encode(body);

      await http.post(
        uri,
        body: jsonBody,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwt"
        }
      ).then((httpResponse){
        if(httpResponse.statusCode >= 200 && httpResponse.statusCode < 400) {
          Map<String, dynamic> dataJson = jsonDecode(httpResponse.body);
          response = PaymentMethod.fromJson(dataJson);
        } else {
          debugPrint(httpResponse.body);
        }
      }).catchError((error) {
        debugPrint("User repository addPaymentMethod error: $error");
      });

      return response;
  }

  @override
  Future<PaymentMethod?> updatePaymentMethod({
    required String jwt,
    required String paymentMethodId,
    required Map<String, dynamic> body
  }) async {
    var uri = Uri.parse("${Constants.borlaGoBaseUrl}/user/payment-method/detail/$paymentMethodId/");
    PaymentMethod? response;
    String jsonBody = json.encode(body);

    await http.patch(
        uri,
        body: jsonBody,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwt"
        }
    ).then((httpResponse){
      if(httpResponse.statusCode >= 200 && httpResponse.statusCode < 400) {
        Map<String, dynamic> dataJson = jsonDecode(httpResponse.body);
        response = PaymentMethod.fromJson(dataJson);
      } else {
        debugPrint(httpResponse.body);
      }
    }).catchError((error) {
      debugPrint("User repository updatePaymentMethod error: $error");
    });

    return response;
  }

  @override
  Future<List<PaymentMethod?>?> getPaymentMethods({
    required String jwt
  }) async {
      var uri = Uri.parse("${Constants.borlaGoBaseUrl}/user/payment-method/all/");
      List<PaymentMethod?>? response;

      await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwt"
        }
      ).then((httpResponse) {
        if(httpResponse.statusCode >= 200 && httpResponse.statusCode < 400) {
          List<dynamic> dataList = jsonDecode(httpResponse.body);
          response = dataList.map((paymentMethod) =>
            PaymentMethod.fromJson(paymentMethod)).toList();
        } else {
          debugPrint(httpResponse.body);
        }
      }).catchError((error) {
        debugPrint("User repository getPaymentMethods error: $error");
      });

      return response;
  }


  @override
  Future<bool> deletePaymentMethod({
    required String jwt,
    required String paymentMethodId
  }) async {
    bool success = false;
    var uri = Uri.parse("${Constants.borlaGoBaseUrl}/user/payment-method/detail/$paymentMethodId/");

    await http.delete(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $jwt"
      }
    ).then((httpResponse) {
      if(httpResponse.statusCode >= 200 && httpResponse.statusCode < 400) {
        success = true;
      } else {
        debugPrint(httpResponse.body);
      }
    }).catchError((error) {
      debugPrint("User repository deletePaymentMethod error: $error");
    });

    return success;
  }

  @override
  Future<List<Payment?>?> getPaymentHistory({required String jwt}) async {
    var uri = Uri.parse("${Constants.borlaGoBaseUrl}/user/payments/all/");
    List<Payment?>? response;

    await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwt"
        }
    ).then((httpResponse) {
      if(httpResponse.statusCode >= 200 && httpResponse.statusCode < 400) {
        List<dynamic> dataList = jsonDecode(httpResponse.body);
        response = dataList.map((paymentMethod) =>
          Payment.fromJson(paymentMethod)).toList();
      } else {
        debugPrint(httpResponse.body);
      }
    }).catchError((error) {
      debugPrint("User repository getPaymentHistory error: $error");
    });

    return response;
  }

  @override
  Future<bool> changePassword({
    required String jwt,
    required Map<String, dynamic> body
  }) async {
    var uri = Uri.parse("${Constants.borlaGoBaseUrl}/user/password/change/");
    bool success = false;
    String jsonBody = json.encode(body);

    await http.patch(
        uri,
        body: jsonBody,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwt"
        }
    ).then((httpResponse) {
      if(httpResponse.statusCode >= 200 && httpResponse.statusCode < 400) {
        success = true;
      } else {
        debugPrint(httpResponse.body);
      }
    }).catchError((error) {
      debugPrint("User repository changeUser error: $error");
    });

    return success;
  }


}