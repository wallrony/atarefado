import 'package:afazeres/facade/facade.dart';
import 'package:afazeres/model/todo.dart';
import 'package:flutter/material.dart';

class TODOListProvider with ChangeNotifier {
  List<TODO> _todoList;

  List<TODO> get list => _todoList;

  static String _lastFilter;

  loadTodoList({String filter}) async {
    final result = await Facade().getTodoList(filter);

    if (result[0]) {
      List<TODO> list = result[1];

      list.sort((a, b) {
        var firstDateSplit = a.date.split('/');
        ;
        var secondDateSplit = b.date.split('/');

        DateTime dateTime1 = DateTime.parse(
            "${firstDateSplit[2]}${firstDateSplit[1]}${firstDateSplit[0]}");
        DateTime dateTime2 = DateTime.parse(
            "${secondDateSplit[2]}${secondDateSplit[1]}${secondDateSplit[0]}");

        return dateTime1.isAfter(dateTime2) ? 1 : -1;
      });

      this._todoList = result[1];
    } else {
      this._todoList = [];
    }

    notifyListeners();

    _lastFilter = filter;
  }

  addTodo(TODO todo) async {
    await Facade().addTodo(todo);

    loadTodoList(filter: _lastFilter);
  }

  removeTodo(int index) async {
    await Facade().deleteTODO(list[index].id);

    loadTodoList(filter: _lastFilter);
  }

  updateTodo(int index, TODO todo) async {
    await new Facade().updateTodo(todo);

    if (index == -1) {
      print(list.length);
      for (var i = 0; i < list.length; i++) {
        if (list[i].id == todo.id) {
          index = i;
          break;
        }
      }
    }

    this._todoList[index] = todo;

    loadTodoList(filter: _lastFilter);
  }
}
