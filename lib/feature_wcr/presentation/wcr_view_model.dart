import 'dart:io';
import 'package:borlago/base/di/get_it.dart';
import 'package:borlago/feature_authentication/providers/authentication_provider.dart';
import 'package:borlago/feature_wcr/domain/models/wcr.dart';
import 'package:borlago/feature_wcr/domain/use_cases/wcr_use_cases.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';

class WCRViewModel {
  final wcrUseCases = getIt<WCRUseCases>();
  final authProvider = getIt<AuthenticationProvider>();

  Future<WCR?> createWCR({
    required XFile wastePhoto,
    required String pickUpLocation,
    required String wasteDesc,
    required String wasteType,
  }) async {
    WCR? wcr;
    try {
      final wastePhotoUrl = await wcrUseCases.uploadImageToSupabase(
        userId: authProvider.user!.id,
        wastePhoto: wastePhoto
      );

      wcr = await wcrUseCases.createWCR(
        jwt: authProvider.jwt!,
        wastePhoto: wastePhotoUrl!,
        pickUpLocation: pickUpLocation,
        wasteDesc: wasteDesc,
        wasteType: wasteType
      );

    } catch(error) {
      debugPrint("WCR view model createWCR error: $error");
    }
    return wcr;
  }

  Future<List<WCR?>?> listWCR() async {
    List<WCR?>? wcrs;
    try {
      wcrs = await wcrUseCases.listWCR(jwt: authProvider.jwt!);
    } catch(error) {
      debugPrint("WCR view model listWCR error: $error");
    }

    return wcrs;
  }

  Future<WCR?> cancelWCR({required String wcrId}) async {
    WCR? wcr;
    try {
      wcr = await wcrUseCases.cancelWCR(jwt: authProvider.jwt!, wcrId: wcrId);
    } catch(error) {
      debugPrint("WCR view model cancelWCR error: $error");
    }

    return wcr;
  }

  Future<bool> deleteWCR({
    required String wcrId,
    required String photoUrl
  }) async {
    bool success = false;
    bool supabaseSuccess = false;
    try {
      supabaseSuccess = await wcrUseCases.deleteImageFromSupabase(
        photoUrl: photoUrl
      );

      if(supabaseSuccess) {
        success = await wcrUseCases.deleteWCR(
          jwt: authProvider.jwt!,
          wcrId: wcrId
        );
      }
    } catch(error) {
      debugPrint("WCR view model deleteWCR error: $error");
    }

    return success;
  }
}