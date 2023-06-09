import 'dart:io';
import 'package:borlago/feature_wcr/domain/models/wcr.dart';
import 'package:camera/camera.dart';

abstract class WCRRepository {
  Future<double?> createWCR({
    required String jwt,
    required Map<String, dynamic> body
  });

  Future<WCR?> getWCR({
    required String jwt,
    required String wcrId
  });

  Future<List<WCR?>?> listWCR({required String jwt});

  Future<String?> uploadImageToSupabase({
    required String userId,
    required XFile wastePhoto
  });
}