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
  static const String userprefId = 'userprefId';
  static const String lang = 'lang';
  static const String fontSize = 'fontSize';
  static const String tempFormat = 'tempFormat';
  static const String location = 'location';
  static const String theme = 'theme';
  static const String prefalertId = 'prefalertId';
  static const String conserveEnergy = 'conserveEnergy';
  static const String conserveWater = 'conserveWater';
  static const String apiRelated = 'apiRelated';

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

  static Future<void> setUserPrefId(int val) async =>
      await _prefs.setInt(SharedPrefUtil.userprefId, val);

  static Future<void> setLanguage(String val) async =>
      await _prefs.setString(SharedPrefUtil.lang, val);

  static Future<void> setFontSize(String val) async =>
      await _prefs.setString(SharedPrefUtil.fontSize, val);

  static Future<void> setTempFormat(String val) async =>
      await _prefs.setString(SharedPrefUtil.tempFormat, val);

  static Future<void> setLocation(String val) async =>
      await _prefs.setString(SharedPrefUtil.location, val);

  static Future<void> setTheme(String val) async =>
      await _prefs.setString(SharedPrefUtil.theme, val);

  static Future<void> setUserPrefAlertId(int val) async =>
      await _prefs.setInt(SharedPrefUtil.prefalertId, val);

  static Future<void> setConserveEnergy(String val) async =>
      await _prefs.setString(SharedPrefUtil.conserveEnergy, val);

  static Future<void> setConserveWater(String val) async =>
      await _prefs.setString(SharedPrefUtil.conserveWater, val);

  static Future<void> setApiRelated(String val) async =>
      await _prefs.setString(SharedPrefUtil.apiRelated, val);

  static Future<void> setLogout() async => await _prefs.clear();

  static Future<void> setUserLogin(Map user) async {
    setIsLoggedIn(true);
    setUserId(user[userId]);
    setUserFirstName(user[firstName]);
    setUserLastName(user[lastName]);
    setUsername(user[username]);
    setUserPrefId(user[userprefId]);
    setLanguage(user[lang]);
    setFontSize(user[fontSize]);
    setTempFormat(user[tempFormat]);
    setLocation(user[location]);
    setTheme(user[theme]);
    setUserPrefAlertId(user[prefalertId]);
    setConserveEnergy(user[conserveEnergy]);
    setConserveWater(user[conserveWater]);
    setApiRelated(user[apiRelated]);
  }

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

  static int getUserPrefId() => _prefs.getInt(SharedPrefUtil.userprefId) ?? 0;

  static String getLanguage() => _prefs.getString(SharedPrefUtil.lang) ?? 'err';

  static String getFontSize() =>
      _prefs.getString(SharedPrefUtil.fontSize) ?? 'err';

  static String getTempFormat() =>
      _prefs.getString(SharedPrefUtil.tempFormat) ?? 'err';

  static String getLocation() =>
      _prefs.getString(SharedPrefUtil.location) ?? 'err';

  static String getTheme() => _prefs.getString(SharedPrefUtil.theme) ?? 'err';

  static int getUserPrefAlertId() =>
      _prefs.getInt(SharedPrefUtil.prefalertId) ?? 0;

  static String getConserveEnergy() =>
      _prefs.getString(SharedPrefUtil.conserveEnergy) ?? 'err';

  static String getConserveWater() =>
      _prefs.getString(SharedPrefUtil.conserveWater) ?? 'err';

  static String getApiRelated() =>
      _prefs.getString(SharedPrefUtil.apiRelated) ?? 'err';

  static Future<void> checkAllPrefs() async {
    print(getIsLoggedIn());
    print(getUserId());
    print(getUserFirstName());
    print(getUserLastName());
    print(getUsername());
    print(getUserPrefId());
    print(getLanguage());
    print(getFontSize());
    print(getTempFormat());
    print(getLocation());
    print(getTheme());
    print(getUserPrefAlertId());
    print(getConserveEnergy());
    print(getConserveWater());
    print(getApiRelated());
  }
}
