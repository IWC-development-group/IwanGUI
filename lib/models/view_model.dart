import 'package:iwangui/services/iwan_api_service.dart';
import 'dart:io';

class IwanPage {
  int id;
  String name;
  String namespace;
  String _content;

  bool isLoaded = false;
  bool isLoading = false;

  String get content {
    if (isLoaded){
      return _content;
    }
    else {
      loadContent();
      return _content;
    }
  }

  Future<void> loadContent() async {
    if (isLoaded || isLoading){ return; }
    else {
      isLoading = true;

      Map<String, dynamic> response = await IwanApiService().getPage(namespace: namespace, page: name);
      if (response["status"] == "OK") {
        _content = response["content"];

        isLoaded = true;
        isLoading = false;
      }
    }
  }

  IwanPage({required this.id, required this.name, required this.namespace}) : _content = "# Page not loaded!";
}

class Namespace {
  int id;
  String name;
  Map<int, IwanPage>? _pages;
  Map<int, IwanPage>? get pages => _pages;

  bool loaded = false;

  Namespace({required this.id, required this.name});

  Future<void> loadPages() async {
    List<Map<String, dynamic>> responses = await IwanApiService().getPages(namespace: name);
    _pages = <int, IwanPage>{};
    for (var response in responses) {
      if (response["status"] == "OK") {
        var counter = 1;
        for (var page in response["pages"]) {
          _pages?.addAll({counter: IwanPage(id: counter, name: page, namespace: name)});
          ++counter;
        }
        loaded = true;
      }
    }
  }

  IwanPage? getPage(int pageID) {
    return pages?[pageID];
  }

  List<IwanPage> getPagesList(){
    return _pages?.values.toList() ?? [];
  }
}

class IwanManager {
  Map<int, Namespace>? _namespaces;
  Map<int, Namespace>? get namespaces => _namespaces;

  IwanManager();

  Future<void> loadNamespaces() async {
    List<Map<String,dynamic>> responses = await IwanApiService().getNamespaces();
    _namespaces = <int, Namespace>{};
    for (var response in responses) {
      if (response["status"] == "OK") {
        var counter = 1;
        for (var namespace in response["namespaces"]) {
          _namespaces?.addAll({counter : Namespace(id: counter, name: namespace)});
          ++counter;
        }
      }
    }
  }

  Namespace? getNamespace(int namespaceID) {
    return namespaces?[namespaceID];
  }

  List<Namespace> getNamespacesList() {
    return namespaces?.values.toList() ?? [];
  }
}
