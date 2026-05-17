import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

class DarkTheme {
  //Text

  static final textStyle = TextStyle(color: Colors.white);
  static final pathBackgroundColor = const Color.fromARGB(255, 40, 40, 40); 

  //Widgets
  static final textButtonStyle = TextButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      foregroundColor: const Color.fromARGB(255, 201, 201, 201),
      textStyle: TextStyle(fontSize: 15));

  //Window

  static final backgroundColor = const Color.fromARGB(255, 60, 60, 60);
  static final appBarColor = const Color.fromARGB(255, 44, 44, 44);

  static final markdownTheme = MarkdownStyleSheet(
    a: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
    h1: TextStyle(color: Color.fromARGB(255, 92, 190, 255)),
    h2: TextStyle(color: Color.fromARGB(255, 92, 190, 255)),
    h3: TextStyle(color: Color.fromARGB(255, 92, 190, 255)),
    h4: TextStyle(color: Color.fromARGB(255, 92, 190, 255)),
    h5: TextStyle(color: Color.fromARGB(255, 92, 190, 255)),
    h6: TextStyle(color: Color.fromARGB(255, 92, 190, 255)),
    p: TextStyle(color: Colors.white),
    listBullet: TextStyle(color: Colors.white),
    code: TextStyle(color: Colors.white, backgroundColor: Colors.grey[800])
  );
}