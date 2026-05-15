import 'package:flutter/material.dart';
import 'package:iwangui/models/view_model.dart';


class ViewViewModel extends ChangeNotifier {
  final IwanManager _iwanManager;

  ViewViewModel() : _iwanManager = IwanManager();

  Future<List<Namespace>> loadNamespaces() async {
    await _iwanManager.loadNamespaces();
    return _iwanManager.getNamespacesList();
  }

  Future<List<IwanPage>> loadPages(int namespaceID) async {
    final namespace = _iwanManager.getNamespace(namespaceID);
    if (namespace != null) {
      await namespace.loadPages();
      return namespace.getPagesList();
    }
    else {return [];}
  }

  IwanPage? loadPage(int namespaceID, int pageID) {
    final namespace = _iwanManager.getNamespace(namespaceID);
    if (namespace != null) {
      if (namespace.loaded) {
        return namespace.getPage(pageID);
      }
    }
    
    return null;
  }
}