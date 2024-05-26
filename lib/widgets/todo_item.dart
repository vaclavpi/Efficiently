import 'package:flutter/material.dart';
import 'package:efficiently/models/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;

  ToDoItem(this.todo);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: todo.isCompleted ? 4 : 0, // Efekt pro splněné úkoly
      child: ListTile(
        leading: Icon(todo.category.icon),
        title: Text(todo.title),
        subtitle: Text(todo.description),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            // Implementace mazání úkolu
          },
        ),
      ),
    );
  }
}
