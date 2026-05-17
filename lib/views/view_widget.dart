import 'package:flutter/material.dart';
import 'package:iwangui/models/view_model.dart';
import 'package:iwangui/styles/dark_theme.dart';
import 'package:iwangui/viewmodels/view_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

class ViewPageNavigator extends StatelessWidget {
  String name = "Обзор";
  Function pingUpdate;

  void setName(String value) {
    name = value;
    pingUpdate();
  }

  ViewPageNavigator({super.key, required this.pingUpdate});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (_) => MaterialPageRoute(builder:(context) => ViewPage(changeTabName: setName))
    );
  }
}

class ViewPage extends StatefulWidget {
  Function changeTabName;

  ViewPage({super.key, required this.changeTabName});
  @override
  _ViewPageState createState() => _ViewPageState(changeTabName: changeTabName);
}

class _ViewPageState extends State<ViewPage> {
  final Function changeTabName;

  _ViewPageState({required this.changeTabName});

  //Init

  @override
  void initState() {
    super.initState();
    _loadNamespaces();
  }
  //State

  List<Namespace> _namespaces = [];
  bool _isLoadingNamespaces = true;

  Future<void> _loadNamespaces() async{
    _isLoadingNamespaces = true;
    final viewModel = Provider.of<ViewViewModel>(context, listen: false);
    final namespaces = await viewModel.loadNamespaces();

    setState(() {
      _namespaces = namespaces;
      _isLoadingNamespaces = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewViewModel>(
        builder: (context, viewModel, child) {
          if (_isLoadingNamespaces){
            return Center(child: CircularProgressIndicator());
          }

          return ListView.separated(
            separatorBuilder:(context, index) => Divider(),
            padding: EdgeInsets.all(15),
            itemCount: _namespaces.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  width: double.infinity,
                  color: DarkTheme.pathBackgroundColor,
                  child: Text("namespaces/", style: DarkTheme.textStyle));
              }

              --index;

              return GestureDetector(
                onTap: () {
                  changeTabName(_namespaces[index].name);

                  Navigator.push(context, 
                    MaterialPageRoute(builder:(context) => PagesView(changeTabName: changeTabName, namespaceID: _namespaces[index].id, namespaceVisualName: _namespaces[index].name ?? "unknown",))
                  );
                },
                child: Text(_namespaces[index].name, style: DarkTheme.textStyle));
            },
          );
        },
      );
  }
}

class PagesView extends StatefulWidget {
  final Function changeTabName;
  final int namespaceID;
  final String namespaceVisualName;

  PagesView({super.key, required this.namespaceID, required this.namespaceVisualName, required this.changeTabName});

  @override
  _PagesViewState createState() => _PagesViewState(namespaceID: namespaceID, namespaceVisualName: namespaceVisualName, changeTabName: changeTabName);
}

class _PagesViewState extends State<PagesView> {
  Function changeTabName;

  final int namespaceID;
  final String namespaceVisualName;

  _PagesViewState({required this.namespaceID, required this.namespaceVisualName, required this.changeTabName});

  //Init

  @override
  void initState() {
    super.initState();
    _loadPages();
  }
  //State

  List<IwanPage> _pages = [];
  bool _isLoadingPages = true;

  Future<void> _loadPages() async {
    _isLoadingPages = true;
    final viewModel = Provider.of<ViewViewModel>(context, listen: false);
    final pages = await viewModel.loadPages(namespaceID);

    setState(() {
      _pages = pages;
      _isLoadingPages = false;
    });
  }

  //State

 @override
  Widget build(BuildContext context) {
    return Consumer<ViewViewModel>(builder: (context, viewModel, child) {
      if (_isLoadingPages){
          return Center(child: CircularProgressIndicator());
      }

      return ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        padding: EdgeInsets.all(15),
        itemCount: _pages.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              width: double.infinity,
              color: DarkTheme.pathBackgroundColor,
              child: Text("namespaces/$namespaceVisualName/", style: DarkTheme.textStyle));
          }
          else if (index == 1) {
            return GestureDetector(
              onTap: () {
                changeTabName("Обзор");
                Navigator.pop(context);
              },
              child: Text("...", style: DarkTheme.textStyle),
            ); 
          }
          
          index-=2;

          return GestureDetector(
            onTap: () {
              changeTabName(_pages[index].name);
              Navigator.push(context, MaterialPageRoute(builder:(context) => PageView(pageID: _pages[index].id, namespaceID: namespaceID, changeTabName: changeTabName)));
            },
            child: Text(_pages[index].name, style: DarkTheme.textStyle,),
          );
        },
      );
    });
  }
}

class PageView extends StatefulWidget {
  final Function changeTabName;

  final int pageID;
  final int namespaceID;

  PageView({super.key, required this.pageID, required this.namespaceID, required this.changeTabName});
  @override
  _PageViewState createState() => _PageViewState(pageID: pageID, namespaceID: namespaceID, changeTabName: changeTabName);
}

class _PageViewState extends State<PageView> {
  Function changeTabName;

  final int pageID;
  final int namespaceID;

  //State

  bool _isPageLoading = true;
  IwanPage? _page;
  String? _pageContent;

  @override
  void initState() {
    super.initState();
    _loadPageData();
  }

  Future<void> _loadPageData() async {
    _isPageLoading = true;
    final viewModel = Provider.of<ViewViewModel>(context, listen: false);

    final page = viewModel.loadPage(namespaceID, pageID);
    final content = await page?.content;

    setState(() {
      _page = page;
      _pageContent = content;
      _isPageLoading = false;
    });
  }

  _PageViewState({required this.pageID, required this.namespaceID, required this.changeTabName});

  @override
  Widget build(BuildContext context) {
    if (_isPageLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(
          onPressed: () { 
            changeTabName(_page?.namespace ?? "Unknown Page");
            Navigator.pop(context);
          },
          color: Colors.white
        ),
        backgroundColor: const Color.fromARGB(255, 71, 71, 71),
        title: Text("${_page?.name ?? "Unknown"}", style: DarkTheme.textStyle),
      ),
      backgroundColor: DarkTheme.backgroundColor,

      body: Markdown(
        data: _pageContent ?? "# Page not loaded",
        styleSheet: DarkTheme.markdownTheme)
    );
  }
}