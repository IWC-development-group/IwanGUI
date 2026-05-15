import 'package:iwangui/services/iwan_api_service.dart';
import 'dart:io';

class IwanPage {
  int id;
  String? name;
  String? namespace;
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
      File contentFile = File("C:/Users/hejdj/Desktop/Другое/IwanServer/Fanfictions/ronald.md");
      _content = await contentFile.readAsString();
      isLoaded = true;
      isLoading = false;
    }
  }

  IwanPage({required this.id, required this.name, required this.namespace}) : _content = "# Page not loaded!";
}

class Namespace {
  int id;
  String? name;
  Map<int, IwanPage>? _pages;
  Map<int, IwanPage>? get pages => _pages;

  bool loaded = false;

  Namespace({required this.id, required this.name});

  Future<void> loadPages() async {
    //Debug load

    await Future.delayed(Duration(milliseconds: 500));

    _pages = <int, IwanPage>{
      1 : IwanPage(id: 1, name: "Page1", namespace: name),
      2 : IwanPage(id: 2, name: "Page2", namespace: name),
      3 : IwanPage(id: 3, name: "Page3", namespace: name),
      4 : IwanPage(id: 4, name: "Page4", namespace: name),
    };

    loaded = true;
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
    //Debug namespaces list
    await Future.delayed(Duration(milliseconds: 500));

    _namespaces = <int, Namespace>{
      1 : Namespace(id: 1, name: "Namespace1"),
      2 : Namespace(id: 2, name: "Namespace2"),
      3 : Namespace(id: 3, name: "Namespace3"),
      4 : Namespace(id: 4, name: "Namespace4")
    };
  }

  Namespace? getNamespace(int namespaceID) {
    return namespaces?[namespaceID];
  }

  List<Namespace> getNamespacesList() {
    return namespaces?.values.toList() ?? [];
  }
}
