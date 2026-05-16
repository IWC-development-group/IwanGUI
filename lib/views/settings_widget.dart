import 'package:flutter/material.dart';
import 'package:iwangui/styles/dark_theme.dart';

class SettingPageNavigator extends StatelessWidget {
  const SettingPageNavigator({super.key});
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) => MaterialPageRoute(builder:(context) => SettingPage())
    );
  }
}

class SettingPage extends StatefulWidget {
  const SettingPage ({super.key});
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  List<TextEditingController> _controllers = [];
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Settings page", style: DarkTheme.textStyle),
    );
  }
}