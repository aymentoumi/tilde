import 'package:flutter/material.dart';
import 'package:shopping_cart/components/item_btn.dart';

import '../models/item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => ListView(
        children: Item.all.map((e) {
          return ListTile(
            title: Text(e.name ?? ''),
            subtitle: Text(e.price ?? ''),
            trailing: ~ItemBtn(e),
          );
        }).toList(),
      );
}
