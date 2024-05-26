import 'package:flutter/material.dart';
import 'package:efficiently/models/todo.dart';

class ToDoProvider with ChangeNotifier {
  List<ToDo> _todos = [];

  List<ToDo> get todos => _todos;

  void addToDo(ToDo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void updateToDo(ToDo updatedToDo) {
    final index = _todos.indexWhere((todo) => todo.id == updatedToDo.id);
    if (index != -1) {
      _todos[index] = updatedToDo;
      notifyListeners();
    }
  }

  void removeToDo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }
}
