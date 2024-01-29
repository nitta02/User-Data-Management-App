import 'dart:io';

import 'package:crud_app/model/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  //Variable
  static const dbName = 'users_db.db';
  static const version = 1;
  static const dbTable = 'users_Table';

  static const columnId = 'id';
  static const columnName = 'name';
  static const columnDes = 'description';

  String sql =
      "CREATE TABLE $dbTable($columnId INTEGER PRIMARY KEY, $columnName TEXT NOT NULL,$columnDes TEXT NOT NULL)";

//CONSTRUCTOR
  static final DatabaseHelper instance = DatabaseHelper();

  static Database? _database;

//DATABASE initialized

  Future<Database?> get database async {
    // if (_database != null) {
    //   return _database;
    // }
    _database ??= await initDB();
    return _database;
  }

  initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    return await openDatabase(
      path,
      version: version,
      onCreate: (db, version) async => await db.execute(sql),
    );
  }

  // static Future getDB() async {
  //   String sql =
  //       "CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT NOT NULL,contact TEXT NOT NULL,description TEXT NOT NULL)";
  //   return openDatabase(
  //     join(await getDatabasesPath(), dbName),
  //     version: version,
  //     onCreate: (db, version) async => await db.execute(sql),
  //   );
  // }

  //INSERT METHOD

  static Future<int> addUser(Users users) async {
    final db = await instance.database;
    return await db!.insert(
      dbTable,
      users.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //UPDATE MEMTHOD
  static Future<int> updateUsers(Users users) async {
    final db = await instance.database;
    return await db!.update(
      dbTable,
      users.toJson(),
      where: "id=?",
      whereArgs: [users.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //DELETE METHOD
  static Future<int> deleteUsers(Users users) async {
    final db = await instance.database;
    return await db!.update(
      dbTable,
      users.toJson(),
      where: "$columnId = ?",
      whereArgs: [users.id],
    );
  }

  //RETRIEVE LIST

  static Future<List<Users>> getAllUsers() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db!.query(dbTable);
    return List.generate(maps.length, (index) => Users.fromJson(maps[index]));
  }
}
