import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS User(
    userId integer PRIMARY KEY AUTOINCREMENT,
    firstName text NOT NULL,
    lastName text NOT NULL,
    username text NOT NULL,
    password text NOT NULL
    )""");
    await database.execute("""CREATE TABLE IF NOT EXISTS Preference(
    userprefId integer PRIMARY KEY REFERENCES User(userId) ON DELETE CASCADE,
    lang text default "English",
    fontSize text default "Medium",
    tempFormat text default "F",
    location text default "Bakersfield",
    theme text default "Light"
    )""");
    await database.execute("""CREATE TABLE IF NOT EXISTS Alerts(
    prefalertId integer PRIMARY KEY REFERENCES Preference(userprefId) ON DELETE CASCADE,
    conserveEnergy text default "Off",
    conserveWater text default "Off",
    apiRelated text default "Off"
    )""");
    await database.execute("""CREATE TABLE IF NOT EXISTS WeatherData(
    apiResponseId integer PRIMARY KEY AUTOINCREMENT,
    userId integer NOT NULL,
    apiCallDate text NOT NULL,
    location text NOT NULL,
    rain real default NULL,
    temp real NOT NULL,
    humidity real NOT NULL,
    snow real default NULL,
    pressure real default NULL,
    windSpeed real default NULL,
    FOREIGN KEY (userId) REFERENCES User(userId) ON DELETE CASCADE
    )""");
    await database.execute("PRAGMA foreign_keys = ON");
  }

  static Future<void> createTriggers(sql.Database database) async {
    await database.execute("""
    CREATE TRIGGER IF NOT EXISTS purgeWeatherData
    BEFORE INSERT ON WeatherData
    BEGIN
    	DELETE FROM WeatherData WHERE apiCallDate IN 
    	(
    		SELECT apiCallDate FROM WeatherData 
        WHERE apiCallDate < (SELECT datetime('now','-14 days','localtime'))
    	);
    END
    """);
  }

  static Future<void> insertData(sql.Database database) async {
    await database
        .execute("""INSERT INTO User(firstName, lastName, username, password) 
    VALUES 
    ('Bobby', 'Hill', 'testing', '123'), 
    """);
    await database.execute(
        """INSERT INTO Preference(lang, fontSize, tempFormat, location, theme) 
    VALUES 
    ('English', 'Small', 'F', 'Bakersfield', 'Light'),
    """);
    await database.execute(
        """INSERT INTO Alerts(conserveEnergy, conserveWater, apiRelated) 
    VALUES 
    ('Off', 'Off', 'Off'),
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'version_one.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
        await createTriggers(database);
        await insertData(database);
      },
    );
  }

  // Create new user
  static Future<void> createUser(String? firstName, String? lastName,
      String? username, String? password) async {
    final db = await SQLHelper.db();
    db.rawQuery("""INSERT INTO User(firstName, lastName, username, password) 
    VALUES (?, ?, ?, ?)""", [firstName, lastName, username, password]);
    db.rawQuery("""INSERT INTO Preference DEFAULT VALUES""");
    db.rawQuery("""INSERT INTO Alerts DEFAULT VALUES""");
  }

  // Create new weather data points
  static Future<void> createWeatherData(
      int? userId,
      String? apiCallDate,
      String? location,
      double? rain,
      double? temp,
      double? humidity,
      double? snow,
      double? pressure,
      double? windSpeed) async {
    final db = await SQLHelper.db();
    db.rawQuery(
        """INSERT INTO WeatherData(userId, apiCallDate, location, rain, temp, humidity, snow, pressure, windSpeed) 
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)""",
        [
          userId,
          apiCallDate,
          location,
          rain,
          temp,
          humidity,
          snow,
          pressure,
          windSpeed
        ]);
  }

  // Select a single user by username
  static Future<List<Map<dynamic, dynamic>>> getUserByUsername(
      String? username) async {
    sql.Database db = await SQLHelper.db();
    return db
        .rawQuery("SELECT * FROM User WHERE username = ? LIMIT 1", [username]);
  }

  // Select user, preference, and alert info by userId
  static Future<List<Map<String, dynamic>>> getUserInfo(int userId) async {
    final db = await SQLHelper.db();
    return db.rawQuery("""SELECT u.*, p.*, a.* FROM User AS u
     INNER JOIN Preference AS p ON u.userId = ? 
     INNER JOIN Alerts AS a ON p.userprefId = a.prefalertId
     WHERE u.userId = p.userprefId  
     """, [userId]);
  }

  // Select weather data stored by userId
  static Future<List<Map<String, dynamic>>> getUserData(int userId) async {
    final db = await SQLHelper.db();
    return db.rawQuery("""SELECT w.* FROM User AS u
     INNER JOIN WeatherData AS w ON u.userId = ?
     WHERE u.userId = w.userId  
     """, [userId]);
  }

  // Select all userprefIds
  static Future<List<Map<String, dynamic>>> getUserPref(int userId) async {
    final db = await SQLHelper.db();
    return db
        .rawQuery("SELECT * FROM Preference WHERE userprefId = ?", [userId]);
  }

  // Select all api calls in the past 3 hrs
  static Future<List<Map<String, dynamic>>> getFrequency(int userId) async {
    final db = await SQLHelper.db();
    return db.rawQuery("""SELECT COUNT(*) FROM WeatherData  
     WHERE apiCallDate > (SELECT datetime('now','-3 hours', 'localtime')) AND userId = ? 
     """, [userId]);
  }

  // Update user's profile info
  static Future<List<Map<String, dynamic>>> updateUser(String? firstName,
      String? lastName, String? username, String? password, int userId) async {
    final db = await SQLHelper.db();
    return db.rawQuery(
        "UPDATE User SET firstName = ?, lastName = ?, username = ?, password = ? WHERE userId = ?",
        [firstName, lastName, username, password, userId]);
  }

  // Update password
  static Future<void> updatePassword(String? username, String? password) async {
    final db = await SQLHelper.db();
    db.rawQuery("UPDATE User SET password = ? WHERE username = ?",
        [password, username]);
  }

  // Update language
  static Future<void> updateLang(int userprefId, String lang) async {
    final db = await SQLHelper.db();
    db.rawQuery("UPDATE Preference SET lang = ? WHERE userprefId = ?",
        [lang, userprefId]);
  }

  // Update font size
  static Future<void> updateSize(int userprefId, String fontSize) async {
    final db = await SQLHelper.db();
    db.rawQuery("UPDATE Preference SET fontSize = ? WHERE userprefId = ?",
        [fontSize, userprefId]);
  }

  // Update temp format
  static Future<void> updateTemp(int userprefId, String tempFormat) async {
    final db = await SQLHelper.db();
    db.rawQuery("UPDATE Preference SET tempFormat = ? WHERE userprefId = ?",
        [tempFormat, userprefId]);
  }

  // Update location
  static Future<void> updateLocation(int userprefId, String location) async {
    final db = await SQLHelper.db();
    db.rawQuery("UPDATE Preference SET location = ? WHERE userprefId = ?",
        [location, userprefId]);
  }

  // Update theme
  static Future<void> updateTheme(int userprefId, String theme) async {
    final db = await SQLHelper.db();
    db.rawQuery("UPDATE Preference SET theme = ? WHERE userprefId = ?",
        [theme, userprefId]);
  }

  // Update energy alerts
  static Future<void> updateEnergyAlerts(
      int prefalertId, bool conserveEnergy) async {
    final db = await SQLHelper.db();
    db.rawQuery(
        """UPDATE Alerts SET conserveEnergy = ? WHERE prefalertId = ?""",
        [conserveEnergy.toString(), prefalertId]);
  }

  // Update water alerts
  static Future<void> updateWaterAlerts(
      int prefalertId, bool conserveWater) async {
    final db = await SQLHelper.db();
    db.rawQuery("""UPDATE Alerts SET conserveWater = ? WHERE prefalertId = ?""",
        [conserveWater.toString(), prefalertId]);
  }

  // Update api related alerts
  static Future<void> updateApiAlerts(int prefalertId, bool apiRelated) async {
    final db = await SQLHelper.db();
    db.rawQuery("""UPDATE Alerts SET apiRelated = ? WHERE prefalertId = ?""",
        [apiRelated.toString(), prefalertId]);
  }
}
