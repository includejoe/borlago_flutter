import 'dart:convert';
import 'dart:io';
import 'package:borlago/base/di/get_it.dart';
import 'package:borlago/base/utils/constants.dart';
import 'package:borlago/feature_wcr/domain/models/wcr.dart';
import 'package:borlago/feature_wcr/domain/repository/wcr_repo.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:supabase/supabase.dart';

class WCRRepositoryImpl extends WCRRepository {
  @override
  Future<WCR?> createWCR({
    required String jwt,
    required Map<String, dynamic> body
  }) async {
    var uri = Uri.parse("${Constants.borlaGoBaseUrl}/wcr/create/");
    WCR? response;
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
        response = WCR.fromJson(dataJson);
      } else {
        debugPrint(httpResponse.body);
      }
    }).catchError((error) {
      debugPrint("WCR repository createWCR error: $error");
    });

    return response;
  }

  @override
  Future<WCR?> getWCR({
    required String jwt,
    required String wcrId
  }) async {
    var uri = Uri.parse("${Constants.borlaGoBaseUrl}/wcr/detail/$wcrId/");
    WCR? response;

    await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $jwt"
      }
    ).then((httpResponse) {
      if(httpResponse.statusCode >= 200 && httpResponse.statusCode < 400) {
        Map<String, dynamic> dataJson = jsonDecode(httpResponse.body);
        response = WCR.fromJson(dataJson);
      } else {
        debugPrint(httpResponse.body);
      }
    }).catchError((error) {
      debugPrint("WCR repository getWCR error: $error");
    });

    return response;
  }

  @override
  Future<WCR?> cancelWCR({
    required String jwt,
    required String wcrId
  }) async {
    var uri = Uri.parse("${Constants.borlaGoBaseUrl}/wcr/cancel/$wcrId/");
    WCR? response;

    await http.patch(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwt"
        }
    ).then((httpResponse) {
      if(httpResponse.statusCode >= 200 && httpResponse.statusCode < 400) {
        Map<String, dynamic> dataJson = jsonDecode(httpResponse.body);
        response = WCR.fromJson(dataJson);
      } else {
        debugPrint(httpResponse.body);
      }
    }).catchError((error) {
      debugPrint("WCR repository cancelWCR error: $error");
    });

    return response;
  }

  @override
  Future<bool> deleteWCR({
    required String jwt,
    required String wcrId
  }) async {
    var uri = Uri.parse("${Constants.borlaGoBaseUrl}/wcr/detail/$wcrId/");
    bool success = false;

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
      debugPrint("WCR repository deleteWCR error: $error");
    });

    return success;
  }

  @override
  Future<List<WCR?>?> listWCR({required String jwt}) async {
    var uri = Uri.parse("${Constants.borlaGoBaseUrl}/wcr/user/all/");
    List<WCR?>? response;

    await http.get(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $jwt"
      }
    ).then((httpResponse) {
      if(httpResponse.statusCode >= 200 && httpResponse.statusCode < 400) {
        List<dynamic> dataList = jsonDecode(httpResponse.body);
        response = dataList.map((wcr) => WCR.fromJson(wcr)).toList();
      } else {
        debugPrint(httpResponse.body);
      }
    }).catchError((error) {
      debugPrint("WCR repository listWCR error: $error");
    });

    return response;
  }

  @override
  Future<String?> uploadImageToSupabase({
    required String userId,
    required XFile wastePhoto
  }) async {
    final supabase = getIt.get<SupabaseClient>();
    String? response;

    try {
      String imagePath = await supabase
        .storage
        .from("waste_photos")
        .upload("$userId/${wastePhoto.name}", File(wastePhoto.path));

      // get only the path after waste_photos/
      imagePath = imagePath.split("waste_photos/").elementAt(1);

      response = supabase.storage.from("waste_photos").getPublicUrl(imagePath);
    } catch(error) {
      debugPrint('Supabase storage upload error : $error');
    }

    return response;
  }

  @override
  Future<bool> deleteImageFromSupabase({
    required String photoUrl,
  }) async {
    final supabase = getIt.get<SupabaseClient>();
    bool success = false;
    final filePath = photoUrl.substring(photoUrl.indexOf("waste_photos/") + 13);
    try {
      await supabase.storage.from("waste_photos")
      .remove([filePath]).then((value) {
        success = true;
      });
    } catch(error) {
      debugPrint('Supabase storage delete error : $error');
    }

    return success;
  }
}