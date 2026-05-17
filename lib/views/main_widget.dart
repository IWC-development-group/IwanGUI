import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  final ScrollController _scrollController = ScrollController();

  void pingUpdate() {
    setState(() {});
  }

  late List<Widget> pages = <Widget>[
    SettingPageNavigator(key: UniqueKey()),
    ViewPageNavigator(pingUpdate: () => pingUpdate(), key: UniqueKey())
  ];


  void selectPage(int id) {
    setState(() {
      _selectedPage = id;    
    });
  }

  void resetPages() async {
    final model = Provider.of<ViewViewModel>(context,listen: false);
    await model.loadNamespaces(force: true);
    
    setState(() {

      pages = <Widget>[
        SettingPageNavigator(key: UniqueKey()),
        ViewPageNavigator(pingUpdate: () => pingUpdate(), key: UniqueKey())
      ];
      _selectedPage = 1;
    });
  }

  void addPage() {
    setState(() {
      pages.add(ViewPageNavigator(pingUpdate: () => pingUpdate()));
    });
  }

  String getTabName(int index) {
    var page = pages[index];
    if (page is ViewPageNavigator) {
      return page.name;
    }

    return "Unknown";
  }

  Widget _buildPages() {
    List<TextButton> buttons = [];

    for (int i = 1; i < pages.length; i++) {
      buttons.add(TextButton(
        onPressed: () => selectPage(i),
        style: DarkTheme.textButtonStyle,
        child: Text(getTabName(i)))
      );
    }

    return Scrollbar(
      scrollbarOrientation: ScrollbarOrientation.bottom,
      controller: _scrollController,
      thumbVisibility: true,
      interactive: true,
      thickness: 5,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: AlwaysScrollableScrollPhysics(),
        child: Row(children: buttons)
      ));
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
        title: _buildPages(),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              addPage();
            }, 
            style: DarkTheme.textButtonStyle,
            icon: Icon(Icons.add)),
          IconButton(
            onPressed: () => selectPage(0), 
            style: DarkTheme.textButtonStyle,
            icon: Icon(Icons.settings)),
          IconButton.outlined(
            onPressed: () => resetPages(), 
            icon: Icon(Icons.update))
        ],
      ),
      body: IndexedStack(index: _selectedPage, children: pages),
    );
  }
}

