import 'dart:io';
import 'package:borlago/feature_wcr/domain/models/wcr.dart';
import 'package:camera/camera.dart';

abstract class WCRRepository {
  Future<WCR?> createWCR({
    required String jwt,
    required Map<String, dynamic> body
  });

  Future<WCR?> getWCR({
    required String jwt,
    required String wcrId
  });

  Future<WCR?> cancelWCR({
    required String jwt,
    required String wcrId
  });

  Future<bool> deleteWCR({
    required String jwt,
    required String wcrId
  });

  Future<List<WCR?>?> listWCR({required String jwt});

  Future<String?> uploadImageToSupabase({
    required String userId,
    required XFile wastePhoto
  });

  Future<bool> deleteImageFromSupabase({
    required String photoUrl,
  });
}