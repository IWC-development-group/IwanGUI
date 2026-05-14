import 'package:flutter/material.dart';
import 'package:iwangui/styles/dark_theme.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Settings page", style: DarkTheme.textStyle),
    );
  }
}