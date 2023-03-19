import 'package:flutter/material.dart';
import 'package:shopping_cart/cart_app.dart';
import 'package:tilde/tilde.dart';

class Header extends Component {
  String _title = '';

  set title(String txt) => setState(() => _title = txt);

  @override
  Widget render(BuildContext context) => AppBar(
        leading: SPA.of()?.route == '/cart'
            ? IconButton(
                onPressed: () => SPA.of()?.route = '/',
                icon: const Icon(Icons.home))
            : null,
        title: Text(_title),
        centerTitle: true,
        actions: [
          Switch(
            value: SPA.of<CartApp>()?.theme.value ==
                ThemeData.dark(),
            onChanged: ((value) => setState(
                  () => SPA.of<CartApp>()?.theme.value =
                      value ? ThemeData.dark() : ThemeData.light(),
                )),
          )
        ],
      );
}
