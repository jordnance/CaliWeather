import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

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
  static const String password = 'password';
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
  static const String isEnabled = 'isEnabled';
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';
  static const String isTempGraph = 'isTempGraph';
  static const String isRainGraph = 'isRainGraph';
  static const String isWindGraph = 'isWindGraph';
  static const String isSnowGraph = 'isSnowGraph';
  static const String isHumGraph = 'isHumGraph';
  static const String isPressGraph = 'isPressGraph';

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

  static Future<void> setPassword(String val) async =>
      await _prefs.setString(SharedPrefUtil.password, val);

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

  static Future<void> setConserveEnergy(bool val) async =>
      await _prefs.setBool(SharedPrefUtil.conserveEnergy, val);

  static Future<void> setConserveWater(bool val) async =>
      await _prefs.setBool(SharedPrefUtil.conserveWater, val);

  static Future<void> setApiRelated(bool val) async =>
      await _prefs.setBool(SharedPrefUtil.apiRelated, val);

  static Future<void> setServiceEnabled(bool val) async =>
      await _prefs.setBool(SharedPrefUtil.isEnabled, val);

  static Future<void> setLatitude(double val) async =>
      await _prefs.setDouble(SharedPrefUtil.latitude, val);

  static Future<void> setLongitude(double val) async =>
      await _prefs.setDouble(SharedPrefUtil.longitude, val);

  static Future<void> setLogout() async => await _prefs.clear();

  static Future<void> setIsTempGraph(bool val) async =>
      await _prefs.setBool(SharedPrefUtil.isTempGraph, val);

  static Future<void> setIsRainGraph(bool val) async =>
      await _prefs.setBool(SharedPrefUtil.isRainGraph, val);

  static Future<void> setIsWindGraph(bool val) async =>
      await _prefs.setBool(SharedPrefUtil.isWindGraph, val);

  static Future<void> setIsSnowGraph(bool val) async =>
      await _prefs.setBool(SharedPrefUtil.isSnowGraph, val);

  static Future<void> setIsHumGraph(bool val) async =>
      await _prefs.setBool(SharedPrefUtil.isHumGraph, val);

  static Future<void> setIsPressGraph(bool val) async =>
      await _prefs.setBool(SharedPrefUtil.isPressGraph, val);

  static Future<void> setUserLogin(Map user) async {
    setIsLoggedIn(true);
    setUserId(user[userId]);
    setUserFirstName(user[firstName]);
    setUserLastName(user[lastName]);
    setUsername(user[username]);
    setPassword(user[password]);
    setUserPrefId(user[userprefId]);
    setLanguage(user[lang]);
    setFontSize(user[fontSize]);
    setTempFormat(user[tempFormat]);
    setLocation(user[location]);
    setTheme(user[theme]);
    setUserPrefAlertId(user[prefalertId]);
    setConserveEnergy(false);
    setConserveWater(false);
    setApiRelated(false);
    setServiceEnabled(true);
    setLatitude(35.393528);
    setLongitude(-119.043732);
    setIsTempGraph(true);
    setIsRainGraph(false);
    setIsWindGraph(false);
    setIsSnowGraph(false);
    setIsHumGraph(false);
    setIsPressGraph(false);
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

  static String getPassword() =>
      _prefs.getString(SharedPrefUtil.password) ?? 'err';

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

  static bool getConserveEnergy() =>
      _prefs.getBool(SharedPrefUtil.conserveEnergy) ?? false;

  static bool getConserveWater() =>
      _prefs.getBool(SharedPrefUtil.conserveWater) ?? false;

  static bool getApiRelated() =>
      _prefs.getBool(SharedPrefUtil.apiRelated) ?? false;

  static bool getIsServiceEnabled() =>
      _prefs.getBool(SharedPrefUtil.isEnabled) ?? false;

  static double getLatitude() =>
      _prefs.getDouble(SharedPrefUtil.latitude) ?? 35.393528;

  static double getLongitude() =>
      _prefs.getDouble(SharedPrefUtil.longitude) ?? -119.043732;

  static bool getIsTempGraph() =>
      _prefs.getBool(SharedPrefUtil.isTempGraph) ?? true;

  static bool getIsRainGraph() =>
      _prefs.getBool(SharedPrefUtil.isRainGraph) ?? false;

  static bool getIsWindGraph() =>
      _prefs.getBool(SharedPrefUtil.isWindGraph) ?? false;

  static bool getIsSnowGraph() =>
      _prefs.getBool(SharedPrefUtil.isSnowGraph) ?? false;

  static bool getIsHumGraph() =>
      _prefs.getBool(SharedPrefUtil.isHumGraph) ?? false;

  static bool getIsPressGraph() =>
      _prefs.getBool(SharedPrefUtil.isPressGraph) ?? false;

  static Future<void> checkAllPrefs() async {
    developer.log(
      getIsLoggedIn().toString(),
      name: 'debug_sharedpref.LoggedIn',
    );
    developer.log(
      getUserId().toString(),
      name: 'debug_sharedpref.UserId',
    );
    developer.log(
      getUserFirstName(),
      name: 'debug_sharedpref.UserFirstName',
    );
    developer.log(
      getUserLastName(),
      name: 'debug_sharedpref.UserLastName',
    );
    developer.log(
      getUsername(),
      name: 'debug_sharedpref.Username',
    );
    developer.log(
      getUserPrefId().toString(),
      name: 'debug_sharedpref.UserPrefId',
    );
    developer.log(
      getLanguage(),
      name: 'debug_sharedpref.Language',
    );
    developer.log(
      getFontSize(),
      name: 'debug_sharedpref.FontSize',
    );
    developer.log(
      getTempFormat(),
      name: 'debug_sharedpref.TempFormat',
    );
    developer.log(
      getLocation(),
      name: 'debug_sharedpref.Location',
    );
    developer.log(
      getTheme(),
      name: 'debug_sharedpref.Theme',
    );
    developer.log(
      getUserPrefAlertId().toString(),
      name: 'debug_sharedpref.PrefAlertId',
    );
    developer.log(
      getConserveEnergy().toString(),
      name: 'debug_sharedpref.ConserveEnergy',
    );
    developer.log(
      getConserveWater().toString(),
      name: 'debug_sharedpref.ConserveWater',
    );
    developer.log(
      getApiRelated().toString(),
      name: 'debug_sharedpref.ApiRelated',
    );
    developer.log(
      getIsServiceEnabled().toString(),
      name: 'debug_sharedpref.IsServiceEnabled',
    );
    developer.log(
      getLatitude().toString(),
      name: 'debug_sharedpref.Latitude',
    );
    developer.log(
      getLongitude().toString(),
      name: 'debug_sharedpref.Longitude',
    );
    developer.log(
      getIsTempGraph().toString(),
      name: 'debug_sharedpref.IsTempGraph',
    );
    developer.log(
      getIsRainGraph().toString(),
      name: 'debug_sharedpref.IsRainGraph',
    );
    developer.log(
      getIsWindGraph().toString(),
      name: 'debug_sharedpref.IsWindGraph',
    );
    developer.log(
      getIsSnowGraph().toString(),
      name: 'debug_sharedpref.IsSnowGraph',
    );
    developer.log(
      getIsHumGraph().toString(),
      name: 'debug_sharedpref.IsHumGraph',
    );
    developer.log(
      getIsPressGraph().toString(),
      name: 'debug_sharedpref.IsPressGraph',
    );
  }
}
