import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DAO {
  static final DAO _instance = DAO.getInstance();
  DAO.getInstance();

  factory DAO() => _instance;
  static Database _database;

  Future<Database> get database async {
    if(_database != null) {
      return _database;
    }

    _database = await _initDB();

    return _database;
  }

  Future _initDB() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'newtap.db');

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(db, version) async {
    String query = "CREATE TABLE IF NOT EXISTS TODO(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, description TEXT, todo_date TEXT, realized INTEGER);";

    await db.execute(query);
  }

  close() async {
    var db = await database;

    return db.close();
  }
}
