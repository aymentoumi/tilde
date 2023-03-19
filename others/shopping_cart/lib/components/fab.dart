import 'package:flutter/material.dart';
import 'package:shopping_cart/cart_app.dart';
import 'package:tilde/tilde.dart';

class Fab extends Component {
  bool _visible = false;

  set visible(bool v) => setState(() => _visible = v);

  @override
  Widget render(BuildContext context) => Visibility(
      visible: _visible,
      child: FloatingActionButton.extended(
        onPressed: () => SPA.of()?.route = '/cart',
        label: Text(
            '${SPA.of<CartApp>()?.cart.nbItems} item${SPA.of<CartApp>()!.cart.nbItems > 1 ? 's' : ''}'),
      ));
}
