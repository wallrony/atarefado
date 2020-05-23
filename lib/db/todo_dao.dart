import 'package:afazeres/db/dao.dart';
import 'package:afazeres/model/todo.dart';

import 'package:sqflite/sqflite.dart';

class TODODAO {
  add(TODO todo) async {
    var result = true;

    try {
      final Database db = await DAO.getInstance().database;

      await db.insert(
        "TODO",
        todo.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (error) {
      print("An error has occurred: $error");
      result = false;
    }

    return result;
  }

  Future<List<dynamic>> indexAll(String filter) async {
    var result = true;
    List<TODO> todoList = new List();

    try {
      final Database db = await DAO.getInstance().database;

      final List<Map<String, dynamic>> response = await db.query(
        "TODO",
        where: filter == null ? null : filter,
      );

      for (Map<String, dynamic> item in response) {
        todoList.add(new TODO(
            id: item['id'],
            name: item['name'],
            description: item['description'],
            date: item['todo_date'],
            realized: item['realized'] > 0));
      }
    } catch (error) {
      print("An error has occurred: $error");
      result = false;
    }

    return [result, todoList];
  }

  delete(int id) async {
    var result = true;

    try {
      final Database db = await DAO.getInstance().database;

      var rowsAffected = await db.delete(
        "TODO",
        where: 'id = ?',
        whereArgs: [id],
      );

      result = rowsAffected > 0;
    } catch (error) {
      print("An error has occurred: $error");
      result = false;
    }

    return result;
  }

  update(TODO todo) async {
    var result = true;

    try {
      final Database db = await DAO.getInstance().database;

      var rowsAffected = await db.update(
        "TODO",
        todo.toJson(),
        where: 'id = ?',
        whereArgs: [todo.id],
      );

      result = rowsAffected > 0;
    } catch (error) {
      print("An error has occurred: $error");
      result = false;
    }

    return result;
  }
}
