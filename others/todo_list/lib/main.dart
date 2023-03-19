import 'package:flutter/material.dart';
import 'package:todo_list/todo_app.dart';

void main() {
  final app = TodoApp();
  runApp(MaterialApp.router(
    debugShowCheckedModeBanner: false,
    routeInformationParser: app.routeInformationParser,
    routerDelegate: app.routerDelegate,
  ));
}
