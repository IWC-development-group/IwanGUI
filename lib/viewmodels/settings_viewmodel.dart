import 'package:flutter/material.dart';
import 'package:iwangui/models/settings_model.dart';

class SettingsViewModel extends ChangeNotifier{
  SettingsModel _model = SettingsModel();

  List<String> urls = [];

  Future<void> loadConfig() async {
    urls = await _model.loadConfig();
  }

  Future<void> saveConfig() async {

  }
}