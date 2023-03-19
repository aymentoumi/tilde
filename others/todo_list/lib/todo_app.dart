import 'package:flutter/material.dart';
import 'package:tilde/tilde.dart';
import 'package:todo_list/components/h_text.dart';
import 'package:todo_list/components/todo_list.dart';
import 'package:todo_list/models/todo.dart';
import 'package:velocity_x/velocity_x.dart';

class TodoApp extends SPA {
  final _tfCtrl = TextEditingController();

  final headerText = HText('Todo List (0/0)');
  final _todosList = TodoList();

  void updateTitle() {
    headerText.text = 'Todo List (${_todosList.nDone}/${_todosList.nAll})';
  }

  void addTodo(Todo todo) {
    _todosList.addTodo(todo);
    updateTitle();
  }

  void removeTodo(Todo todo) {
    _todosList.removeTodo(todo);
    updateTitle();
  }

  @override
  Widget onNavigate(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: ~headerText,
          centerTitle: true,
        ),
        body: <Widget>[
          'New Task:'.text.xl2.extraBlack.make(),
          TextField(
              controller: _tfCtrl,
              decoration: const InputDecoration(
                filled: true,
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                hoverColor: Colors.white,
              ),
              onSubmitted: (text) {
                addTodo(Todo(text));
                _tfCtrl.clear();
              }),
          ~_todosList,
        ]
            .column(crossAlignment: CrossAxisAlignment.start)
            .p32()
            .card
            .gray200
            .make()
            .p8(),
      );

  @override
  String? onChanging(String newRoute) => '/';
}
