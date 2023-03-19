import 'package:bg_color/colors.dart';
import 'package:bg_color/main.dart';
import 'package:flutter/material.dart';
import 'package:tilde/tilde.dart';
import 'package:velocity_x/velocity_x.dart';

class Chips extends Component {
  final String color;
  bool _visible = true;

  Chips(this.color);

  @override
  Widget render(BuildContext context) => Visibility(
        visible: _visible,
        child: Chip(
          label: Text(color).onTap(() => SPA.of()?.route = '/$color'),
          backgroundColor: colors[color],
          deleteIcon: const Icon(Icons.close),
          onDeleted: () {
            SPA.of<BGColorApp>()?.removeColor(color);
            setState(() => _visible = false);
          },
        ),
      );
}
