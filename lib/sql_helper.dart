import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS User(
    userId integer PRIMARY KEY AUTOINCREMENT,
    username text NOT NULL,
    password text NOT NULL,
    prefId integer default NULL,
    FOREIGN KEY (prefId) REFERENCES Preference(prefId)
    )""");
    await database.execute("""CREATE TABLE IF NOT EXISTS Preference(
    prefId integer PRIMARY KEY AUTOINCREMENT,
    lang text default "English",
    fontSize integer default 12,
    alerts text default NULL,
    tempFormat text default "Fahrenheit",
    theme text default "Light",
    locId integer default NULL,
    FOREIGN KEY (locId) REFERENCES Location(locId)
    )""");
    await database.execute("""CREATE TABLE IF NOT EXISTS Location(
    locId integer PRIMARY KEY AUTOINCREMENT,
    cityName text NOT NULL,
    latitude real NOT NULL,
    longitude real NOT NULL,
    hourlyTemp real default 0.00,
    hourlyRain real default 0.00
    )""");
    await database.execute("PRAGMA foreign_keys = ON");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'caliweather.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new user
  static Future<int> createUser(String username, String password) async {
    final db = await SQLHelper.db();
    final data = {'username': username, 'password': password};
    final userId = await db.insert('User', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return userId;
  }

  // Read a single User by userId
  static Future<List<Map<String, dynamic>>> getUser(int userId) async {
    final db = await SQLHelper.db();
    return db.query('User', where: "userId = ?", whereArgs: [userId], limit: 1);
  }

  // Update language
  static Future<int> updateLang(int userprefId, String lang) async {
    final db = await SQLHelper.db();
    final data = {'lang': lang};
    final result = await db.update('Preference', data,
        where: "userprefId = ?", whereArgs: [userprefId]);
    return result;
  }

  // Update font size
  static Future<int> updateSize(int userprefId, int fontSize) async {
    final db = await SQLHelper.db();
    final data = {'fontSize': fontSize};
    final result = await db.update('Preference', data,
        where: "userprefId = ?", whereArgs: [userprefId]);
    return result;
  }

  // Update alerts
  static Future<int> updateAlerts(int userprefId, String alerts) async {
    final db = await SQLHelper.db();
    final data = {'alerts': alerts};
    final result = await db.update('Preference', data,
        where: "userprefId = ?", whereArgs: [userprefId]);
    return result;
  }

  // Update temp format
  static Future<int> updateTemp(int userprefId, int tempFormat) async {
    final db = await SQLHelper.db();
    final data = {'tempFormat': tempFormat};
    final result = await db.update('Preference', data,
        where: "userprefId = ?", whereArgs: [userprefId]);
    return result;
  }

  // Update theme
  static Future<int> updateTheme(int userprefId, String theme) async {
    final db = await SQLHelper.db();
    final data = {'theme': theme};
    final result = await db.update('Preference', data,
        where: "userprefId = ?", whereArgs: [userprefId]);
    return result;
  }

  // Update city name
  static Future<int> updateCity(int userprefId, String cityName) async {
    final db = await SQLHelper.db();
    final data = {'cityName': cityName};
    final result = await db.update('Preference', data,
        where: "userprefId = ?", whereArgs: [userprefId]);
    return result;
  }
}
