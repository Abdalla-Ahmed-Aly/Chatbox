import 'package:flutter/material.dart';

class TextOverlay {
  String id;
  String text;
  Offset position;
  Color color;
  double fontSize;
  TextAlign textAlign;
  int backgroundClickCount;

  TextOverlay({
    required this.id,
    required this.text,
    required this.position,
    required this.textAlign,
    this.color = Colors.white,
    this.fontSize = 24.0,
    this.backgroundClickCount = 0,
  });

  Color lightenHSL(Color color, [double amount = 0.2]) {
    final hsl = HSLColor.fromColor(color);
    final lighter = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return lighter.toColor();
  }

  Color getBackgroundColor() {
    Color backGroundColor;
    Color originColor = color;
    if (backgroundClickCount == 0) {
      color = originColor;
      backGroundColor = Colors.transparent;
      return backGroundColor;
    } else if (backgroundClickCount == 1) {
      if (color == Colors.white) {
        backGroundColor = Colors.black;
        return backGroundColor;
      } else if (color == Colors.black) {
        backGroundColor = Colors.white;
        return backGroundColor;
      } else {
        backGroundColor = lightenHSL(color);
        return backGroundColor;
      }
    } else {
      if (color == Colors.white) {
        color = Colors.black;
        backGroundColor = Colors.white;
        return backGroundColor;
      } else if (color == Colors.black) {
        color = Colors.white;
        backGroundColor = Colors.black;
        return backGroundColor;
      } else {
        backGroundColor = color;
        color = lightenHSL(color);
        return backGroundColor;
      }
    }
  }
}
