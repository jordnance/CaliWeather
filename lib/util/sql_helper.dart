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
      'sixteen.db',
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

  // Read a single user by username <-- WORKS
  static Future<List<Map<dynamic, dynamic>>> getUserByUsername(
      String username) async {
    sql.Database db = await SQLHelper.db();
    return db
        .rawQuery("SELECT * FROM User WHERE username = ? LIMIT 1", [username]);
  }

  // Read user, preference, and alert info by userId <-- WORKS
  static Future<List<Map<String, dynamic>>> getUserInfo(int userId) async {
    final db = await SQLHelper.db();
    return db.rawQuery("""SELECT u.*, p.*, a.* FROM User AS u
     INNER JOIN Preference AS p ON u.userId = ? 
     INNER JOIN Alerts AS a ON p.userprefId = a.prefalertId
     WHERE u.userId = p.userprefId  
     """, [userId]);
  }

  // Update user's profile info <-- WORKS
  static Future<List<Map<String, dynamic>>> updateUser(String? firstName,
      String? lastName, String? username, String? password, int userId) async {
    final db = await SQLHelper.db();
    return db.rawQuery(
        "UPDATE User SET firstName = ?, lastName = ?, username = ?, password = ? WHERE userId = ?",
        [firstName, lastName, username, password, userId]);
  }

  // Update password <-- WORKS
  static Future<void> updatePassword(String? username, String? password) async {
    final db = await SQLHelper.db();
    db.rawQuery(
        "UPDATE User SET password = ? WHERE username = ?", [password, username]);
  }

  // Update language <-- NEEDS TO BE TESTED
  static Future<void> updateLang(int userprefId, String lang) async {
    final db = await SQLHelper.db();
    db.rawQuery("UPDATE Preference SET lang = ? WHERE userprefId = ?",
        [lang, userprefId]);
  }

  // Update font size <-- NEEDS TO BE TESTED
  static Future<void> updateSize(int userprefId, int fontSize) async {
    final db = await SQLHelper.db();
    db.rawQuery("UPDATE Preference SET fontSize = ? WHERE userprefId = ?",
        [fontSize, userprefId]);
  }

  // Update temp format <-- NEEDS TO BE TESTED
  static Future<void> updateTemp(int userprefId, int tempFormat) async {
    final db = await SQLHelper.db();
    db.rawQuery("UPDATE Preference SET tempFormat = ? WHERE userprefId = ?",
        [tempFormat, userprefId]);
  }

  // Update location <-- NEEDS TO BE TESTED
  static Future<void> updateLocation(int userprefId, String location) async {
    final db = await SQLHelper.db();
    db.rawQuery("UPDATE Preference SET location = ? WHERE userprefId = ?",
        [location, userprefId]);
  }

  // Update theme <-- NEEDS TO BE TESTED
  static Future<void> updateTheme(int userprefId, String theme) async {
    final db = await SQLHelper.db();
    db.rawQuery("UPDATE Preference SET theme = ? WHERE userprefId = ?",
        [theme, userprefId]);
  }

  // Update alerts <-- NEEDS TO BE TESTED
  static Future<void> updateAlerts(int prefalertId, String conserveEnergy,
      String conserveWater, String apiRelated) async {
    final db = await SQLHelper.db();
    db.rawQuery("""UPDATE Alerts SET conserveEnergy = ?, conserveWater = ?, 
    apiRelated = ? WHERE prefalertId = ?""",
        [conserveEnergy, conserveWater, apiRelated, prefalertId]);
  }
}
