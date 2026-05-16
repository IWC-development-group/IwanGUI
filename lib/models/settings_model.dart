import 'dart:convert';
import 'dart:io';

final Map<String, dynamic> baseConfig = {
  "URLS" : <String>[
    "http://localhost:8080"
  ]
};

class SettingsModel {
  Future<List<String>> loadConfig({String path = "Configs"}) async {
    var myDir = Directory(path);
    if (!await myDir.exists()) {
      await myDir.create();
    }

    File file = File("$path/iwanconfig.json");
    if (!await file.exists()) {
      await file.create();
      final baseConfigJsonString = jsonEncode(baseConfig);
      await file.writeAsString(baseConfigJsonString);
      return List<String>.from(baseConfig["URLS"]);
    }

    try {
      final Map<String, dynamic> configString = jsonDecode(await file.readAsString());
      return List<String>.from(configString["URLS"]);
    } catch (e) {
      return <String>["Error load config $e"];
    }
  }

  Future<void> saveConfig({String path = "Configs", required List<String> urls}) async {
    var myDir = Directory(path);
    if (!await myDir.exists()) {
      await myDir.create();
    }

    File file = File("$path/iwanconfig.json");
    final Map<String, dynamic> res = {"URLS" : urls};
    await file.writeAsString(jsonEncode(res));
  } 
}
