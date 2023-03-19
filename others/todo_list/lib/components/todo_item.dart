import 'package:flutter/material.dart';
import 'package:tilde/tilde.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/todo_app.dart';
import 'package:velocity_x/velocity_x.dart';

class TodoItem extends Component {
  final Todo _item;

  TodoItem(this._item);

  @override
  Widget render(BuildContext context) => <Widget>[
        _item.content.text.make().px4().expand(),
        IconButton(
          onPressed: () {
            setState(() => _item.completed = !_item.completed);
            SPA.of<TodoApp>()?.updateTitle();
          },
          icon: Icon(
            Icons.verified,
            color: _item.completed ? Colors.amber : Colors.green,
          ),
        ),
        IconButton(
            onPressed: () =>
                SPA.of<TodoApp>()?.removeTodo(_item),
            icon: const Icon(Icons.delete, color: Colors.red))
      ].row().color(_item.completed ? Colors.lightGreen : Colors.white).p4();
}
