import 'package:flutter/material.dart';
import 'package:iwangui/viewmodels/settings_viewmodel.dart';
import 'package:iwangui/viewmodels/view_viewmodel.dart';
import 'package:iwangui/viewmodels/settings_viewmodel.dart';
import 'package:provider/provider.dart';
import '../views/main_widget.dart';

void main() => runApp(AppWindow());

class AppWindow extends StatelessWidget {
  const AppWindow({super.key});

  @override Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => ViewViewModel()),
      ChangeNotifierProvider(create: (context) => SettingsViewModel())
    ],
    child: MaterialApp(
      title: "IwanGUI",
      home: MainPage(),
    ));
  }
}