import 'package:flutter/material.dart';
import 'package:iwangui/models/main_model.dart';

class CounterViewModel extends ChangeNotifier {
  final CounterModel _model = CounterModel();

  int get count => _model.value;

  void increment() {
    _model.increment();
    notifyListeners();
  }
}