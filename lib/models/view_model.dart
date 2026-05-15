import 'package:iwangui/services/iwan_api_service.dart';

class Page {
  String? name;
  String? namespace;
  String _content;

  bool isLoaded = false;

  String get content {
    if (isLoaded){
      return _content;
    }
    else {
      _content = "# Hello World";
      isLoaded = true;
      return _content;
    }
  }

  Page({required this.name, required this.namespace}) : _content = "# Page not loaded!";
}

class Namespace {
  String? name;
  Map<int, Page>? _pages;
  Map<int, Page>? get pages => _pages;

  Namespace({required this.name});

  void loadPages() {
    //Debug load
    _pages = <int, Page>{
      1 : Page(name: "Страница1", namespace: name),
      2 : Page(name: "Страница1", namespace: name),
    };
  }

  Page? getPage(int pageID) {
    return pages?[pageID];
  }
}

class NamespaceManager {
  Map<int, Namespace>? _namespaces;
  Map<int, Namespace>? get namespaces => _namespaces;

  NamespaceManager() {
    loadNamespaces();
  }

  void loadNamespaces() {
    //Debug namespaces list
    _namespaces = <int, Namespace>{
      1 : Namespace(name: "Test1"),
      2 : Namespace(name: "Test2"),
      3 : Namespace(name: "Test3")
    };
  }

  Namespace? getNamespace(int namespaceID) {
    return namespaces?[namespaceID];
  }
}
