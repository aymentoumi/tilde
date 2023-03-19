import 'package:flutter/material.dart';
import 'package:tilde/tilde.dart';

class HText extends Component {
  String _text;

  HText(this._text);

  set text(String txt) => setState(() => _text = txt);

  @override
  Widget render(BuildContext context) => Text(_text);
}
