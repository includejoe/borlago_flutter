import 'package:borlago/feature_authentication/domain/models/Register.dart';
import 'package:borlago/feature_authentication/domain/models/login.dart';

abstract class AuthenticationRepository {
  Future<Login?> login(Map<String, dynamic> body);
  Future<Register?> register(Map<String, dynamic> body);
}