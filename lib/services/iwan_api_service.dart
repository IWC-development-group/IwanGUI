import 'dart:io';
import 'dart:convert';

import 'package:iwangui/models/settings_model.dart';

const String pageRequest = "/?name=";
const String namespaceRequest = "/pages?namespace=";
const String namespacesRequest = "/namespaces";

class IwanApiService {
  Future<Map<String, dynamic>> requestUrl({required String url}) async {
    var client = HttpClient();

    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    HttpClientResponse response = await request.close();

    final stringData = await response.transform(utf8.decoder).join();

    client.close();

    final Map<String, dynamic> obj = jsonDecode(stringData);

    return obj;
  }

  Future<Map<String, dynamic>> getPages({required String namespace}) async {
    var settings = SettingsModel();
    var testUrl = "http://localhost:8080";
    return await requestUrl(url: "$testUrl$namespaceRequest$namespace");
  }

  Future<Map<String, dynamic>> getNamespaces() async {
    var settings = SettingsModel();
    var testUrl = "http://localhost:8080";
    return await requestUrl(url: "$testUrl$namespacesRequest");
  }

  Future<Map<String, dynamic>> getPage({required String namespace, required String page}) async {
    var settings = SettingsModel();
    var testUrl = "http://localhost:8080";
    return await requestUrl(url: "$testUrl$pageRequest$namespace/$page");
  }
}