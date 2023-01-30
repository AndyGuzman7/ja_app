import 'package:flutter/material.dart';

// Color.fromARGB(255, 102, 133, 230),
//    Color.fromARGB(255, 127, 159, 229)
class CustomColorPrimary {
  Color c = Color(0xFF5B77EE);
  late final int _colorCode;
  final Map<int, Color> _colorCodes = {
    50: Color.fromARGB(255, 91, 119, 238),
    100: const Color.fromARGB(255, 16, 111, 183),
    200: Color.fromARGB(255, 255, 183, 0),
    300: const Color.fromRGBO(255, 255, 222, 0),
    400: Color.fromARGB(255, 247, 247, 247),
    500: Color.fromARGB(255, 91, 119, 238),
    600: Color.fromARGB(255, 29, 99, 245),
    700: Color(0xFFf5af1d),
    800: Color(0xFF06283D),
    900: Color(0xFF1363DF),
  };
  late final MaterialColor _materialColor;

  int get colorCode => _colorCode;

  MaterialColor get materialColor {
    _colorCode = c.value;
    _materialColor = MaterialColor(_colorCode, _colorCodes);
    return _materialColor;
  }
}

class CustomColor extends Color {
  CustomColor(int value, {this.materialColor}) : super(value);
  MaterialColor? materialColor;
}
