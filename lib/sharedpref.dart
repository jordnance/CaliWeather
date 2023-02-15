import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  //STRING NAMES OPERATE AS KEYS FOR SHARED PREFERENCES
  //THESE ARE SET TO MATCH COLUMN NAMES IN DATABASE
  final String isLoggedIn = 'isLoggedIn';
  final String userId = 'userId';
  final String firstName = 'firstName';
  final String lastName = 'lastName';
  final String username = 'username';
  final String lang = 'lang';
  final String fontSize = 'fontSize';
  final String alerts = 'alerts';
  final String tempFormat = 'tempFormat';
  final String theme = 'theme';

  //SETTER FUNCTIONS
  Future<void> setIsLoggedIn(bool isLoggedIn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(this.isLoggedIn, isLoggedIn);
  }

  Future<void> setUserId(int userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(this.userId, userId);
  }

  Future<void> setFirstName(String firstName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.firstName, firstName);
  }

  Future<void> setLastName(String lastName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.lastName, lastName);
  }

  Future<void> setUsername(String username) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.username, username);
  }

  Future<void> setLang(String lang) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.lang, lang);
  }

  Future<void> setFontSize(String fontSize) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.fontSize, fontSize);
  }

  Future<void> setAlerts(String alerts) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.alerts, alerts);
  }

  Future<void> setTempFormat(String tempFormat) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.tempFormat, tempFormat);
  }

  Future<void> setTheme(String theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.theme, theme);
  }

  Future<void> setUserLogin(
    int userId,
    String firstName,
    String lastName,
    String username,
    // String lang,
    // String fontSize,
    // String alerts,
    // String tempFormat,
    // String theme
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setIsLoggedIn(true);
    setUserId(userId);
    setFirstName(firstName);
    setLastName(lastName);
    setUsername(username);
    // setLang(lang);
    // setFontSize(fontSize);
    // setAlerts(alerts);
    // setTempFormat(tempFormat);
    // setTheme(theme);
  }

  Future<void> setUserLogout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  //GETTER FUNCTIONS
  Future<bool> getIsLoggedIn() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(isLoggedIn) ?? false;
  }

  Future<int> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(userId) ?? 0;
  }

  Future<String> getFirstName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(firstName) ?? '';
  }

  Future<String> getLastName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(lastName) ?? '';
  }

  Future<String> getUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(username) ?? '';
  }

  Future<String> getLang() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(lang) ?? '';
  }

  Future<String> getFontSize(String fontSize) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(fontSize) ?? '';
  }

  Future<String> getAlerts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(alerts) ?? '';
  }

  Future<String> getTempFormat() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(tempFormat) ?? '';
  }

  Future<String> getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(theme) ?? '';
  }
}
