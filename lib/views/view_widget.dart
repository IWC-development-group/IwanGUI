import 'package:flutter/material.dart';
import 'package:iwangui/styles/dark_theme.dart';

class ViewPage extends StatelessWidget {
  const ViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("View Page", style: DarkTheme.textStyle),
    );
  }
}