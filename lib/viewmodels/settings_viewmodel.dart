import 'package:flutter/material.dart';
import 'package:iwangui/models/settings_model.dart';

class SettingsViewModel extends ChangeNotifier{
  SettingsModel _model = SettingsModel();

  List<String> getUrls() {
    return _model.urls;
  }

  void setUrls(List<String> urls) {
    _model.urls = urls;
  }

  Future<void> loadConfig() async {
    await _model.loadConfig();
    notifyListeners();
  }

  Future<void> saveConfig() async {
    await _model.saveConfig();
    notifyListeners();
  }
}