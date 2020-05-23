import 'package:afazeres/db/todo_dao.dart';
import 'package:afazeres/model/todo.dart';

class Facade {
  addTodo(TODO todo) async {
    return await TODODAO().add(todo);
  }

 Future<List<dynamic>> getTodoList(String filter) async {
    return await TODODAO().indexAll(filter);
  }

  updateTodo(TODO todo) async {
    return await TODODAO().update(todo);
  }

  deleteTODO(int id) async {
    return await TODODAO().delete(id);
  }
}