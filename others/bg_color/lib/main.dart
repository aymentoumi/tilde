import 'package:bg_color/chips.dart';
import 'package:bg_color/colors.dart';
import 'package:flutter/material.dart';
import 'package:tilde/tilde.dart';
import 'package:velocity_x/velocity_x.dart';

void main() => runApp(~BGColorApp());

class BGColorApp extends SPA {
  final _colors = <String>{};

  bool removeColor(String color) => _colors.remove(color);

  @override
  String onChanging(String newRoute) {
    final color = newRoute.trim().eliminateFirst;
    return (colors[color] == null) ? '/' : newRoute;
  }

  @override
  Widget onNavigate(BuildContext context) {
    final color = route.trim().eliminateFirst;
    if (color.isNotEmptyAndNotNull) {
      _colors.add(color);
    }
    return Scaffold(
      backgroundColor: colors[color],
      body: _colors
          .map(
            (color) => ~Chips(color),
          )
          .toList()
          .row()
          .centered(),
    );
  }
}
