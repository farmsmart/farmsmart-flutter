import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final _firstOpenKey = 'first_open';

  static Future<bool> isFirstLaunch() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(_firstOpenKey) ?? true;
  }

  static Future<bool> setIsFirstLaunch(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool(_firstOpenKey, value);
  }
}
