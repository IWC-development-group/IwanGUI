import 'dart:convert';
import 'dart:io';

final Map<String, dynamic> baseConfig = {
  "URLS" : <String>[
    "http://localhost:8080"
  ]
};

class SettingsModel {
  List<String> _urls = [];

  List<String> get urls => _urls;
  
  set urls (List<String> value) {
    _urls = value;
  }

  SettingsModel._();
  static final SettingsModel _instance  = SettingsModel._();
  factory SettingsModel() => _instance;

  Future<void> loadConfig({String path = "Configs"}) async {
    var myDir = Directory(path);
    if (!await myDir.exists()) {
      await myDir.create();
    }

    File file = File("$path/iwanconfig.json");
    if (!await file.exists()) {
      await file.create();
      final baseConfigJsonString = jsonEncode(baseConfig);
      await file.writeAsString(baseConfigJsonString);
      urls =  List<String>.from(baseConfig["URLS"]);
      return;
    }

    try {
      final Map<String, dynamic> configString = jsonDecode(await file.readAsString());
      urls =  List<String>.from(configString["URLS"]);
      return;
    } catch (e) {
      urls =  <String>["Error load config $e"];
      return;
    }
  }

  Future<void> saveConfig({String path = "Configs"}) async {
    var myDir = Directory(path);
    if (!await myDir.exists()) {
      await myDir.create();
    }

    File file = File("$path/iwanconfig.json");
    final Map<String, dynamic> res = {"URLS" : urls};
    await file.writeAsString(jsonEncode(res));
  } 
}
