import 'dart:convert';
import 'package:borlago/base/utils/constants.dart';
import 'package:borlago/feature_user/domain/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationProvider with ChangeNotifier {
  late SharedPreferences _prefs;
  late User? _user;
  String? _jwt;
  String _currency = "€";

  AuthenticationProvider() {
    init();
  }

  String get currency {
    Constants.currencies.forEach((key, value) {
      if(key == _user!.country) {
        _currency = value;
      }
    });
    return _currency;
  }
  String? get jwt => _jwt;
  User? get user => _user;
  set user(User? user) {
    _user = user;
    _prefs.setString("user", jsonEncode(user?.toJson()));
    notifyListeners();
  }

  login({required jwt, required User user}) {
    _jwt = jwt;
    _user = user;
    _prefs.setString("jwt", jwt);
    _prefs.setString("user", jsonEncode(user.toJson()));
    notifyListeners();
  }

  logout() {
    _prefs.remove("jwt");
    _prefs.remove("user");
    _jwt = null;
    _user = null;
    notifyListeners();
  }

  void init() async {
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
        _user = User.fromJson(json.decode(_prefs.getString("user")!));
      }
    }

    notifyListeners();
  }
}