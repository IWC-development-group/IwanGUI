import 'package:flutter/material.dart';
import 'package:iwangui/styles/dark_theme.dart';
import 'package:iwangui/viewmodels/view_viewmodel.dart';
import 'package:iwangui/views/view_widget.dart';
import 'package:provider/provider.dart';
import 'package:iwangui/views/settings_widget.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedPage = 0;

  void selectPage(int id) {
    setState(() {
      _selectedPage = id;    
    });
  }

  Widget _getBody() {
    late Widget toReturn;
    switch(_selectedPage){
      case 0:
        toReturn = Navigator(
          onGenerateRoute: (_) {
            return MaterialPageRoute(builder:(context) => ViewPage());
          },
        );
        break;
      case 1:
        toReturn = SettingPage();
        break;
    }

    return toReturn;
  }

  @override void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_){
      _loadInitialData();
    });
  }

  Future<void> _loadInitialData() async {
    ViewViewModel viewViewModel = Provider.of<ViewViewModel>(context, listen: false);
    await viewViewModel.loadNamespaces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: DarkTheme.appBarColor,
        centerTitle: false,
        title: Row(children: <Widget>[
          TextButton(
            onPressed: () => selectPage(0),
            style: DarkTheme.textButtonStyle,
            child: Text("Обзор")),
          TextButton(
            onPressed: () => selectPage(1), 
            style: DarkTheme.textButtonStyle,
            child: Text("Настройки"))
        ]),
      ),
      body: _getBody(),
    );
  }
}

