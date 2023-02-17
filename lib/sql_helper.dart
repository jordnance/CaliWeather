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
    location text default "Fresno",
    theme text default "Light"
    )""");
    await database.execute("""CREATE TABLE IF NOT EXISTS Alerts(
    prefalertId integer PRIMARY KEY REFERENCES Preference(userprefId) ON DELETE CASCADE,
    conserveEnergy text default "Off",
    conserveWater text default "Off",
    apiRelated text default "Off"
    )""");
    await database.execute("PRAGMA foreign_keys = ON");
  }

  static Future<void> insertData(sql.Database database) async {
    await database
        .execute("""INSERT INTO User(firstName, lastName, username, password) 
    VALUES 
    ('Bobby', 'Hill', 'testing', '123'), 
    ('Eric', 'Cartman', 'southpark', '456'), 
    ('Peter', 'Griffin', 'familyguy', '789'), 
    ('Quentin', 'Tarantino', 'pulpfiction', '321'), 
    ('Bruce', 'Wayne', 'batman', '654'), 
    ('Patrick', 'Star', 'spongebob', '987'), 
    ('Dennis', 'Reynolds', 'sunny', '090'), 
    ('Matthew', 'McConaughey', 'alright', '181')
    """);
    await database.execute(
        """INSERT INTO Preference(lang, fontSize, tempFormat, location, theme) 
    VALUES 
    ('English', 'Small', 'F', 'Bakersfield', 'Light'),
    ('English', 'Small', 'C', 'Modesto', 'Dark'),
    ('Spanish', 'Small', 'F', 'Chico', 'Light'),
    ('English', 'Medium', 'F', 'Los Angeles', 'Light'), 
    ('English', 'Medium', 'C', 'San Diego', 'Dark'), 
    ('Spanish', 'Medium', 'F', 'Sacramento', 'Light'), 
    ('English', 'Large', 'F', 'San Luis Obispo', 'Light'), 
    ('Spanish', 'Large', 'C', 'Palm Springs', 'Dark')
    """);
    await database.execute(
        """INSERT INTO Alerts(conserveEnergy, conserveWater, apiRelated) 
    VALUES 
    ('Off', 'Off', 'Off'),
    ('On', 'Off', 'Off'),
    ('Off', 'On', 'Off'),
    ('Off', 'Off', 'On'),
    ('On', 'On', 'Off'),
    ('On', 'Off', 'On'),
    ('Off', 'On', 'On'), 
    ('On', 'On', 'On')
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'twelve.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
        await insertData(database);
      },
    );
  }

  // Create new user <-- WORKS
  static Future<void> createUser(String? firstName, String? lastName,
      String? username, String? password) async {
    final db = await SQLHelper.db();
    db.rawQuery("""INSERT INTO User(firstName, lastName, username, password) 
    VALUES (?, ?, ?, ?)""", [firstName, lastName, username, password]);
    db.rawQuery("""INSERT INTO Preference DEFAULT VALUES""");
    db.rawQuery("""INSERT INTO Alerts DEFAULT VALUES""");
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

  // Read a single user by username <-- WORKS
  static Future<List<Map<dynamic, dynamic>>> getUserByUsername(
      String username) async {
    sql.Database db = await SQLHelper.db();
    return db.query('User',
        where: "username = ?", whereArgs: [username], limit: 1);
  }

  // Read a single user by userId <-- WORKS
  static Future<List<Map<String, dynamic>>> getUserById(int userId) async {
    final db = await SQLHelper.db();
    return db.query('User', where: "userId = ?", whereArgs: [userId], limit: 1);
  }

  // Read user, preference, and alert info by userId <-- WORKS
  static Future<List<Map<String, dynamic>>> getUserInfo(int userId) async {
    final db = await SQLHelper.db();
    return db.rawQuery(
        """SELECT u.userId, u.firstName, u.lastName, u.username, p.*, a.* FROM User AS u
     INNER JOIN Preference AS p ON u.userId = ? 
     INNER JOIN Alerts AS a ON p.userprefId = a.prefalertId
     WHERE u.userId = p.userprefId  
     """, [userId]);
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

  // Update location <-- NEEDS TO BE TESTED
  static Future<int> updateCity(int userprefId, String location) async {
    final db = await SQLHelper.db();
    final data = {'location': location};
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
}
