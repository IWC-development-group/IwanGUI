import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:iwangui/models/settings_model.dart';

const String pageRequest = "/?name=";
const String namespaceRequest = "/pages?namespace=";
const String namespacesRequest = "/namespaces";

class IwanApiService {
  Future<Map<String, dynamic>> requestUrl({required String url}) async {
    var client = HttpClient();
    client.idleTimeout = Duration(seconds: 3);

    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    HttpClientResponse response = await request.close();

    final stringData = await response.transform(utf8.decoder).join();

    client.close();

    final Map<String, dynamic> obj = jsonDecode(stringData);

    return obj;
  }

  Future<List<Map<String,dynamic>>> getPages({required String namespace}) async {
    //print("GET PAGES REQUEST");
    var settings = SettingsModel();

    if (!settings.isLoaded) {await settings.loadConfig();}

    List<Future<Map<String,dynamic>>> futures = [];

    for (var url in settings.urls) {
      futures.add(requestUrl(url: "$url$namespaceRequest$namespace"));
    }

    List<Map<String,dynamic>> result = await Future.wait(futures);

    return result;
  }

  Future<List<Map<String,dynamic>>> getNamespaces() async {
    //print("GET NAMESPACES REQUEST");
    var settings = SettingsModel();

    if (!settings.isLoaded) {await settings.loadConfig();}

    List<Future<Map<String,dynamic>>> futures = [];

    for (var url in settings.urls) {
      futures.add(requestUrl(url: "$url$namespacesRequest"));
    }

    List<Map<String,dynamic>> results = await Future.wait(futures); 
    return results;
  }

  Future<Map<String, dynamic>> getPage({required String namespace, required String page}) async {
    //print("GET PAGE REQUEST");
    var settings = SettingsModel();

    if (!settings.isLoaded) {await settings.loadConfig();}

    List<Future<Map<String,dynamic>>> futures = [];
    for (var url in settings.urls) {
      futures.add(requestUrl(url: "$url$pageRequest$namespace/$page"));
    }

    Map<String,dynamic> result = await Future.any(futures);

    return result;
  }
}