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

  //SETTER FUNCTIONS
  static Future<void> setIsLoggedIn(bool val) async =>
      await _prefs.setBool(SharedPrefUtil.isLoggedIn, val);

  // static Future<void> setUserId(int userId) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setInt(this.userId, userId);
  // }

  // static Future<void> setFirstName(String firstName) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString(this.firstName, firstName);
  // }

  // static Future<void> setLastName(String lastName) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString(this.lastName, lastName);
  // }

  // static Future<void> setUsername(String username) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString(this.username, username);
  // }

  // static Future<void> setLang(String lang) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString(this.lang, lang);
  // }

  // static Future<void> setFontSize(String fontSize) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString(this.fontSize, fontSize);
  // }

  // static Future<void> setAlerts(String alerts) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString(this.alerts, alerts);
  // }

  // static Future<void> setTempFormat(String tempFormat) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString(this.tempFormat, tempFormat);
  // }

  // static Future<void> setTheme(String theme) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString(this.theme, theme);
  // }

  // static Future<void> setUserLogin(
  //   int userId,
  //   String firstName,
  //   String lastName,
  //   String username,
  //   // String lang,
  //   // String fontSize,
  //   // String alerts,
  //   // String tempFormat,
  //   // String theme
  // ) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setIsLoggedIn(true);
  //   setUserId(userId);
  //   setFirstName(firstName);
  //   setLastName(lastName);
  //   setUsername(username);
  //   // setLang(lang);
  //   // setFontSize(fontSize);
  //   // setAlerts(alerts);
  //   // setTempFormat(tempFormat);
  //   // setTheme(theme);
  // }

  static Future<void> setUserLogout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  //GETTER FUNCTIONS
  // static Future<bool> getIsLoggedIn() async {
  //   final SharedPreferences pref = await SharedPreferences.getInstance();
  //   return pref.getBool(isLoggedIn) ?? false;
  // }

  static bool getIsLoggedIn() =>
      _prefs.getBool(SharedPrefUtil.isLoggedIn) ?? false;

  // static Future<int> getUserId() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getInt(userId) ?? 0;
  // }

  // static Future<String> getFirstName() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(firstName) ?? '';
  // }

  // static Future<String> getLastName() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(lastName) ?? '';
  // }

  // static Future<String> getUsername() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(username) ?? '';
  // }

  // static Future<String> getLang() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(lang) ?? '';
  // }

  // static Future<String> getFontSize(String fontSize) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(fontSize) ?? '';
  // }

  // static Future<String> getAlerts() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(alerts) ?? '';
  // }

  // static Future<String> getTempFormat() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(tempFormat) ?? '';
  // }

  // static Future<String> getTheme() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(theme) ?? '';
  // }
}
