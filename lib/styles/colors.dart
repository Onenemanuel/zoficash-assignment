import 'package:flutter/material.dart';

class AppColors {
  static const red = Colors.red;
  static const white = Colors.white;
  static const black = Colors.black;
  static const green = Colors.green;
  static const orange = Colors.orange;
  static const blue = Color(0xFF005CEF);
  static const yellow = Color(0xFFFEDE60);
  static final grey = Colors.grey.shade700;
  static const transparent = Colors.transparent;

  static Color lighten({required int percent, required Color color}) {
    assert(1 <= percent && percent <= 100);
    var value = percent / 100;

    return Color.fromARGB(
      color.alpha,
      color.red + ((255 - color.red) * value).round(),
      color.green + ((255 - color.green) * value).round(),
      color.blue + ((255 - color.blue) * value).round(),
    );
  }

  static Color darken({required int percent, required Color color}) {
    assert(1 <= percent && percent <= 100);
    var value = 1 - percent / 100;

    return Color.fromARGB(
      color.alpha,
      (color.red * value).round(),
      (color.green * value).round(),
      (color.blue * value).round(),
    );
  }
}
