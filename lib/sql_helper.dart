import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS User(
    userId integer PRIMARY KEY AUTOINCREMENT,
    username text NOT NULL,
    password text NOT NULL
    )""");
    await database.execute("""CREATE TABLE IF NOT EXISTS Preference(
    userprefId integer PRIMARY KEY REFERENCES User(userId) ON DELETE CASCADE,
    lang text default "English",
    fontSize text default "Medium",
    alerts text default NULL,
    tempFormat text default "Fahrenheit",
    theme text default "Light",
    )""");
    await database.execute("PRAGMA foreign_keys = ON");
  }

  static Future<void> insertData(sql.Database database) async {
    await database.execute("""INSERT INTO User(username, password) 
    VALUES 
    ('testing', '123')""");
    await database.execute(
        """INSERT INTO Preference(lang, fontSize, alerts, tempFormat, theme) 
    VALUES ('English', 'Small', 'Conserve water', 'Fahrenheit', 'Light'),
    ('Spanish', 'Medium', 'Conserve energy', 'Fahrenheit', 'Dark'), 
    ('English', 'Medium', 'Conserve water', 'Celsius', 'Light'), 
    ('English', 'Large', 'Conserve energy', 'Celsius', 'Dark'), 
    ('Spanish', 'Large', 'Conserve water', 'Fahrenheit', 'Light')""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'three.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
        await insertData(database);
      },
    );
  }

  // Create new user <-- WORKS
  static Future<int> createUser(String? username, String? password) async {
    final db = await SQLHelper.db();
    final data = {'username': username, 'password': password};
    final userId = await db.insert('User', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return userId;
  }

  // Read all users <-- NEEDS TO BE TESTED
  static Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await SQLHelper.db();
    return db.query('User', orderBy: "userId");
  }

  // Read a single user by username and password <-- WORKS
  static Future<List<Map<String, dynamic>>> getUser(
      String username, String password) async {
    final db = await SQLHelper.db();
    return db.query('User',
        where: "username = ? AND password = ?",
        whereArgs: [username, password],
        limit: 1);
  }

  // Read a single user by userId <-- WORKS
  static Future<List<Map<String, dynamic>>> getUserById(int userId) async {
    final db = await SQLHelper.db();
    return db.query('User', where: "userId = ?", whereArgs: [userId], limit: 1);
  }

  // Update language <-- NEEDS TO BE TESTED
  static Future<int> updateLang(int userprefId, String lang) async {
    final db = await SQLHelper.db();
    final data = {'lang': lang};
    final result = await db.update('Preference', data,
        where: "userprefId = ?", whereArgs: [userprefId]);
    return result;
  }

  // Update font size <-- NEEDS TO BE TESTED
  static Future<int> updateSize(int userprefId, int fontSize) async {
    final db = await SQLHelper.db();
    final data = {'fontSize': fontSize};
    final result = await db.update('Preference', data,
        where: "userprefId = ?", whereArgs: [userprefId]);
    return result;
  }

  // Update alerts <-- NEEDS TO BE TESTED
  static Future<int> updateAlerts(int userprefId, String alerts) async {
    final db = await SQLHelper.db();
    final data = {'alerts': alerts};
    final result = await db.update('Preference', data,
        where: "userprefId = ?", whereArgs: [userprefId]);
    return result;
  }

  // Update temp format <-- NEEDS TO BE TESTED
  static Future<int> updateTemp(int userprefId, int tempFormat) async {
    final db = await SQLHelper.db();
    final data = {'tempFormat': tempFormat};
    final result = await db.update('Preference', data,
        where: "userprefId = ?", whereArgs: [userprefId]);
    return result;
  }

  // Update theme <-- NEEDS TO BE TESTED
  static Future<int> updateTheme(int userprefId, String theme) async {
    final db = await SQLHelper.db();
    final data = {'theme': theme};
    final result = await db.update('Preference', data,
        where: "userprefId = ?", whereArgs: [userprefId]);
    return result;
  }

  // Update city name <-- NEEDS TO BE TESTED
  static Future<int> updateCity(int userprefId, String cityName) async {
    final db = await SQLHelper.db();
    final data = {'cityName': cityName};
    final result = await db.update('Preference', data,
        where: "userprefId = ?", whereArgs: [userprefId]);
    return result;
  }
}
