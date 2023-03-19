import 'package:flutter/material.dart';
import 'package:shopping_cart/components/app_theme.dart';
import 'package:shopping_cart/components/fab.dart';
import 'package:shopping_cart/components/header.dart';
import 'package:shopping_cart/pages/cart_page.dart';
import 'package:shopping_cart/pages/home_page.dart';
import 'package:tilde/tilde.dart';
import 'package:velocity_x/velocity_x.dart';

class CartApp extends SPA {
  final header = Header();
  final theme = AppTheme(ThemeData.dark());
  final fab = Fab();
  final cart = CartPage();

  @override
  Widget onNavigate(BuildContext context) {
    Widget? body;

    switch (route) {
      case '/':
        header.title = 'HOME';
        body = const HomePage();
        break;
      case '/cart':
        header.title = 'CART (${cart.nbItems})';
        body = ~cart;
        break;
      default:
        header.title = '404';
        body = const Text('NOT FOUND!').centered();
    }

    fab.visible = !cart.isEmpty && route == '/';

    theme.child = Scaffold(
      appBar: (~header).preferredSize(const Size.fromHeight(kToolbarHeight)),
      body: body,
      floatingActionButton: ~fab,
    );

    return ~theme;
  }
}
