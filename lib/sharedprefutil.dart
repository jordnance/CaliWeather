import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtil {
  static late SharedPreferences _prefs;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  //DB COLUMN NAMES OPERATE AS KEYS FOR SHARED PREFERENCES
  static const String isLoggedIn = 'isLoggedIn';
  static const String userId = 'userId';
  static const String firstName = 'firstName';
  static const String lastName = 'lastName';
  static const String username = 'username';
  static const String lang = 'lang';
  static const String fontSize = 'fontSize';
  static const String alerts = 'alerts';
  static const String tempFormat = 'tempFormat';
  static const String theme = 'theme';

  //AMBIGOUS SETTER FUNCTIONS
  static Future<void> setIntByKey(String key, int val) async =>
      await _prefs.setInt(key, val);

  static Future<void> setDoubleByKey(String key, double val) async =>
      await _prefs.setDouble(key, val);

  static Future<void> setStringByKey(String key, String val) async =>
      await _prefs.setString(key, val);

  static Future<void> setStringListByKey(String key, List<String> val) async =>
      await _prefs.setStringList(key, val);

  static Future<void> setBoolByKey(String key, bool val) async =>
      await _prefs.setBool(key, val);

  //USER AND PROFILE SETTERS
  static Future<void> setIsLoggedIn(bool val) async =>
      await _prefs.setBool(SharedPrefUtil.isLoggedIn, val);

  static Future<void> setUserId(int val) async =>
      await _prefs.setInt(SharedPrefUtil.userId, val);

  static Future<void> setUserFirstName(String val) async =>
      await _prefs.setString(SharedPrefUtil.firstName, val);

  static Future<void> setUserLastName(String val) async =>
      await _prefs.setString(SharedPrefUtil.lastName, val);

  static Future<void> setUsername(String val) async =>
      await _prefs.setString(SharedPrefUtil.username, val);

  static Future<void> setLanguage(String val) async =>
      await _prefs.setString(SharedPrefUtil.lang, val);

  static Future<void> setFontSize(String val) async =>
      await _prefs.setString(SharedPrefUtil.fontSize, val);

  static Future<void> setAlerts(String val) async =>
      await _prefs.setString(SharedPrefUtil.alerts, val);

  static Future<void> setTempFormat(String val) async =>
      await _prefs.setString(SharedPrefUtil.tempFormat, val);

  static Future<void> setTheme(String val) async =>
      await _prefs.setString(SharedPrefUtil.theme, val);

  static Future<void> setLogout() async => await _prefs.clear();

  static Future<void> setUserLogin(Map user) async {
    //  userId: 1,
    //  firstName: Bobby,
    //  lastName: Hill,
    //  username: testing,
    //  userprefId: 1,
    //  lang: English,
    //  fontSize: Small,
    //  tempFormat: F,
    //  location: Bakersfield,
    //  theme: Light,
    //  prefalertId: 1,
    //  conserveEnergy: On,
    //  conserveWater: Off,
    //  apiRelated: Off}

    setIsLoggedIn(true);
    setUserId(user[userId]);
    setUserFirstName(user[firstName]);
    setUserLastName(user[lastName]);
    setUsername(user[username]);
  }

  //AMBIGOUS SETTER FUNCTIONS
  // static int getIntByKey(String key) => _prefs.getInt(key) ?? -1;

  // static double getDoubleByKey(String key) => _prefs.getDouble(key) ?? -1;

  // static String getStringByKey(String key) => _prefs.getString(key) ?? 'err';

  // static List<String> getStringListByKey(String key) =>
  //     _prefs.getStringList(key) ?? ['err'];

  // static bool getBoolByKey(String key) => _prefs.getBool(key);

  //USER AND PROFILE GETTER FUNCTIONS
  static bool getIsLoggedIn() =>
      _prefs.getBool(SharedPrefUtil.isLoggedIn) ?? false;

  static int getUserId() => _prefs.getInt(SharedPrefUtil.userId) ?? 0;

  static String getUserFirstName() =>
      _prefs.getString(SharedPrefUtil.firstName) ?? 'err';

  static String getUserLastName() =>
      _prefs.getString(SharedPrefUtil.lastName) ?? 'err';

  static String getUsername() =>
      _prefs.getString(SharedPrefUtil.username) ?? 'err';

  static String getLanguage() => _prefs.getString(SharedPrefUtil.lang) ?? 'err';

  static String getFontSize() =>
      _prefs.getString(SharedPrefUtil.fontSize) ?? 'err';

  static String getAlerts() => _prefs.getString(SharedPrefUtil.alerts) ?? 'err';

  static String getTempFormat() =>
      _prefs.getString(SharedPrefUtil.tempFormat) ?? 'err';

  static String getTheme() => _prefs.getString(SharedPrefUtil.theme) ?? 'err';
}
