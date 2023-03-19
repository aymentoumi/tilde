import 'package:flutter/material.dart';
import 'package:tilde/tilde.dart';

class AppTheme extends Component {
  ThemeData _value;
  Widget? _child;

  AppTheme(this._value, {Widget? child}) : _child = child;

  set value(ThemeData th) => setState(() => _value = th);
  ThemeData get value => _value;

  set child(Widget widget) => setState(() => _child = widget);

  @override
  Widget render(BuildContext context) =>
      Theme(data: _value, child: _child ?? Container());
}
