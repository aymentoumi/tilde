import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Item extends Equatable {
  final String? name;
  final String? price;

  const Item({this.name, this.price});

  @override
  List<Object?> get props => [name];

  static List<Item> get all => [
        const Item(name: 'Keyboard', price: '24'),
        const Item(name: 'Mouse', price: '20'),
        const Item(name: 'LED Screen', price: '44'),
        const Item(name: 'Macbook', price: '240'),
        const Item(name: 'Surface book', price: '204'),
        const Item(name: 'iMac', price: '248'),
        const Item(name: 'Headphones', price: '29'),
        const Item(name: 'USB Storage', price: '19'),
        const Item(name: 'HDD', price: '23'),
      ];

  // static List<Item> cart = [];
}
