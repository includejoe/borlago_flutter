import 'dart:io';
import 'package:borlago/base/di/get_it.dart';
import 'package:borlago/feature_wcr/domain/models/wcr.dart';
import 'package:borlago/feature_wcr/domain/repository/wcr_repo.dart';
import 'package:camera/camera.dart';

class WCRUseCases {
  Future<double?> createWCR({
    required String jwt,
    required String wastePhoto,
    required String pickUpLocation,
    required String wasteDesc,
    required String wasteType,
  }) async {
    Map<String, dynamic> body = {
      "waste_photo": wastePhoto,
      "waste_type": wasteType,
      "waste_desc": wasteDesc,
      "pick_up_location": pickUpLocation
    };

    return getIt.get<WCRRepository>().createWCR(jwt: jwt, body: body);
  }

  Future<WCR?> getWCR({
    required String jwt,
    required String wcrId
  }) async {
    return getIt.get<WCRRepository>().getWCR(jwt: jwt, wcrId: wcrId);
  }

  Future<List<WCR?>?> listWCR({
    required String jwt
  }) async {
    return getIt.get<WCRRepository>().listWCR(jwt: jwt);
  }

  Future<String?> uploadImageToSupabase({
    required String userId,
    required XFile wastePhoto,
}) async {
    return getIt.get<WCRRepository>().uploadImageToSupabase(
      userId: userId,
      wastePhoto: wastePhoto
    );
  }
}