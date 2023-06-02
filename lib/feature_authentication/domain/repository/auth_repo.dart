import 'package:borlago/feature_authentication/domain/models/login.dart';

abstract class AuthenticationRepository {
  Future<Login?> login(Map<String, dynamic> body);
  Future<Login?> register(Map<String, dynamic> body);
}