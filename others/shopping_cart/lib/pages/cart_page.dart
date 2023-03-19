import 'package:flutter/material.dart';
import 'package:shopping_cart/cart_app.dart';
import 'package:tilde/tilde.dart';

import '../models/item.dart';

class CartPage extends Component {
  final _cart = <Item>{};

  void toggle(Item item) => setState(() {
        if (!_cart.add(item)) {
          _cart.remove(item);
        }
      });

  bool contains(Item item) => _cart.contains(item);

  bool get isEmpty => _cart.isEmpty;

  int get nbItems => _cart.length;

  @override
  Widget render(BuildContext context) => ListView(
        children: _cart.map((e) {
          return ListTile(
            title: Text(e.name ?? ''),
            subtitle: Text(e.price ?? ''),
            trailing: IconButton(
                icon: const Icon(Icons.remove_circle),
                onPressed: () {
                  setState(() => _cart.remove(e));
                  SPA.of<CartApp>()?.header.title =
                      'CART ($nbItems)';
                }),
          );
        }).toList(),
      );
}
