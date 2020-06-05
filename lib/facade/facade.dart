import 'package:afazeres/db/shared_pref_data.dart';
import 'package:afazeres/db/todo_dao.dart';
import 'package:afazeres/model/todo.dart';

class Facade {

  /// TODO SQLITE DB OPERATIONS
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

  /// SHARED PREFERENCES OPERATIONS
  getIntroPageShown() async {
    return await new SharedPrefData().getIntroPageShown();
  }

  setAlreadyViewIntroPage() async {
    return await new SharedPrefData().setIntroPageShown();
  }
}