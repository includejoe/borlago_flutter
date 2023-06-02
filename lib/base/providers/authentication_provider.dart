import 'package:borlago/feature_user/domain/models/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationProvider with ChangeNotifier {
  late SharedPreferences _prefs;
  late User? _user;
  String? _jwt;

  AuthenticationProvider() {
    _init();
  }

  String? get jwt => _jwt;
  User? get user => _user;

  login({required String jwt, required User user}) {
    _jwt = jwt;
    _user = user;
    _prefs.setString("jwt", jwt);
    _prefs.setString("user", user.toJson() as String);
  }

  logout() {
    _prefs.remove("jwt");
    _prefs.remove("user");
    _jwt = null;
    _user = null;
  }

  void _init() async {
    _prefs = await SharedPreferences.getInstance();
    String? storedJwt = _prefs.getString("jwt");

    if(storedJwt != null) {
      bool storedJwtExpired = JwtDecoder.isExpired(storedJwt);
      if(storedJwtExpired) {
        _prefs.remove("jwt");
        _prefs.remove("user");
        _jwt = null;
        _user = null;
      } else {
        _jwt = _prefs.getString("jwt");
        _user = User.fromJson(_prefs.getString("user") as Map<String, dynamic>);
      }
    }

    notifyListeners();
  }
}