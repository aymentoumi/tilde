import 'package:flutter/material.dart';
import 'package:shopping_cart/cart_app.dart';

void main() {
  final app = CartApp();
  runApp(MaterialApp.router(
    debugShowCheckedModeBanner: false,
    routeInformationParser: app.routeInformationParser,
    routerDelegate: app.routerDelegate,
  ));
}
