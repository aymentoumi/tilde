import 'package:flutter/material.dart';
import 'package:shopping_cart/cart_app.dart';
import 'package:shopping_cart/models/item.dart';
import 'package:tilde/tilde.dart';

class ItemBtn extends Component {
  final Item _item;

  ItemBtn(this._item);

  @override
  Widget render(BuildContext context) => IconButton(
      icon: Icon(
        SPA.of<CartApp>()!.cart.contains(_item)
            ? Icons.remove_circle
            : Icons.add_circle,
      ),
      onPressed: () {
        setState(() => SPA.of<CartApp>()?.cart.toggle(_item));
        SPA.of<CartApp>()?.fab.visible =
            !SPA.of<CartApp>()!.cart.isEmpty &&
                SPA.of()?.route == '/';
      });
}
