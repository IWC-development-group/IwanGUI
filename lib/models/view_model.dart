import 'package:iwangui/services/iwan_api_service.dart';
import 'dart:io';

class IwanPage {
  int id;
  String name;
  String namespace;
  String _content;

  bool isLoaded = false;
  bool isLoading = false;

  Future<String> get content async {
    if (isLoaded){
      return _content;
    }
    else {
      await loadContent();
      return _content;
    }
  }

  Future<void> loadContent() async {
    if (isLoaded || isLoading){ return; }
    else {
      isLoading = true;

      Map<String, dynamic>? response = await IwanApiService().getPage(namespace: namespace, page: name);
      if (response != null && response["status"] == "OK") {
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

  Namespace({required this.id, required this.name}) : _pages = {};

  Future<void> loadPages() async {
    if (loaded) {return;}
    List<Map<String, dynamic>?> responses = await IwanApiService().getPages(namespace: name);
    var counter = 1;
    for (var response in responses) {
      if (response == null) {continue;}
      if (response["status"] == "OK") {
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
  bool loaded = false;
  IwanManager() : _namespaces = {} ;

  Future<void> loadNamespaces({bool force = false}) async {
    if (loaded && !force) {return;}
    _namespaces = {};
    List<Map<String,dynamic>?> responses = await IwanApiService().getNamespaces();
    var counter = 1;
    for (var response in responses) {
      if (response == null) {continue;}
      if (response["status"] == "OK") {
        for (var namespace in response["namespaces"]) {
          _namespaces?.addAll({counter : Namespace(id: counter, name: namespace)});
          ++counter;
        }
        loaded = true;
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
