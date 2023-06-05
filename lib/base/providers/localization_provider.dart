import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationProvider with ChangeNotifier {
  late SharedPreferences _prefs;
  late Locale _locale;

  LocalizationProvider() {
    _init();
  }

  Locale get locale => _locale;

  setLocale({required Locale locale}) {
    _locale = locale;
    _prefs.setString("locale", locale.languageCode);
    notifyListeners();
  }

  void _init() async {
    _prefs = await SharedPreferences.getInstance();

    if(_prefs.getString("locale") == "en") {
      _locale = const Locale.fromSubtags(languageCode: "en");
    } else if(_prefs.getString("locale") == "fr") {
      _locale = const Locale.fromSubtags(languageCode: "fr");
    } else {
      _locale = const Locale.fromSubtags(languageCode: "en");
    }

    notifyListeners();
  }
}