import 'package:flutter/material.dart';

class DarkTheme {
  //Text

  static final textStyle = TextStyle(color: Colors.white);

  //Widgets
  static final textButtonStyle = TextButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      foregroundColor: const Color.fromARGB(255, 201, 201, 201),
      textStyle: TextStyle(fontSize: 15));

  //Window

  static final backgroundColor = const Color.fromARGB(255, 60, 60, 60);
  static final appBarColor = const Color.fromARGB(255, 44, 44, 44);
}