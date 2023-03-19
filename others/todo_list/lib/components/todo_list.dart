import 'package:flutter/material.dart';
import 'package:tilde/tilde.dart';
import 'package:todo_list/components/todo_item.dart';
import 'package:todo_list/models/todo.dart';
import 'package:velocity_x/velocity_x.dart';

class TodoList extends Component {
  final _todos = <Todo>[];

  int get nDone => _todos.count((todo) => todo.completed);

  int get nAll => _todos.length;

  void addTodo(Todo todo) => setState(() => _todos.add(todo));

  void removeTodo(Todo todo) => setState(() => _todos.remove(todo));

  @override
  Widget render(BuildContext context) =>
      _todos.map((e) => ~TodoItem(e)).toList().column();
}
