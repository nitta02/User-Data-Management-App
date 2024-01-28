import 'package:crud_app/model/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Database {
  static const int version = 1;
  static const String dbName = 'users_db';

  static Future getDB() async {
    String sql =
        "CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT,contact TEXT,description TEXT)";
    return openDatabase(
      join(await getDatabasesPath(), dbName),
      version: version,
      onCreate: (db, version) async => await db.execute(sql),
    );
  }

  //INSERT METHOD

  static Future<int> addUser(Users users) async {
    final db = await getDB();
    return await db.insert(
      "Users",
      users.toJson(),
      ConflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //UPDATE MEMTHOD
  static Future<int> updateUsers(Users users) async {
    final db = await getDB();
    return await db.update(
      "Users",
      users.toJson(),
      where: "id=?",
      whereArgs: [users.id],
      ConflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //DELETE METHOD
  static Future<int> deleteUsers(Users users) async {
    final db = await getDB();
    return await db.update(
      "Users",
      users.toJson(),
      where: "id=?",
      whereArgs: [users.id],
    );
  }

  //RETRIEVE LIST

  static Future<List<Users>> getAllUsers() async {
    final db = await getDB();
    final List<Map<String, dynamic>> maps = await db.query("Users");
    return List.generate(maps.length, (index) => Users.fromJson(maps[index]));
  }
}
