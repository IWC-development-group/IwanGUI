import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

final Map<String, dynamic> baseConfig = {
  "URLS" : <String>[
    "http://localhost:8080"
  ]
};

class SettingsModel {
  List<String> _urls = [];
  bool isLoaded = false;

  List<String> get urls => _urls;

  set urls (List<String> value) {
    _urls = value;
  }

  SettingsModel._();
  static final SettingsModel _instance  = SettingsModel._();
  factory SettingsModel() => _instance;

  Future<String> getAppPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<void> loadConfig({String path = "Configs"}) async {
    var basePath = await getAppPath();
    var myDir = Directory("$basePath/$path");

    if (!await myDir.exists()) {
      await myDir.create(recursive: true);
    }

    File file = File("${myDir.path}/iwanconfig.json");
    if (!await file.exists()) {
      await file.create(recursive: true);
      final baseConfigJsonString = jsonEncode(baseConfig);
      await file.writeAsString(baseConfigJsonString);
      urls =  List<String>.from(baseConfig["URLS"]);
      isLoaded = true;
      return;
    }

    try {
      final Map<String, dynamic> configString = jsonDecode(await file.readAsString());
      urls =  List<String>.from(configString["URLS"]);
      isLoaded = true;
      return;
    } catch (e) {
      urls =  <String>["Error load config $e"];
      return;
    }
  }

  Future<void> saveConfig({String path = "Configs"}) async {
    var basePath = await getAppPath();
    var myDir = Directory("$basePath/$path");

    if (!await myDir.exists()) {
      await myDir.create(recursive: true);
    }

    File file = File("${myDir.path}/iwanconfig.json");
    final Map<String, dynamic> res = {"URLS" : urls};
    await file.writeAsString(jsonEncode(res));
  } 
}
