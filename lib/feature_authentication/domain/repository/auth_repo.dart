import 'package:borlago/feature_authentication/domain/models/Register.dart';
import 'package:borlago/feature_authentication/domain/models/login.dart';

abstract class AuthenticationRepository {
  Future<LoginResponse?> login(Login body);
  Future<Register?> register(Register body);
}