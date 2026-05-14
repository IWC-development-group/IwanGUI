import 'package:flutter/material.dart';
import 'package:iwangui/viewmodels/main_viewmodel.dart';
import 'package:provider/provider.dart';
import '../views/main_widget.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => CounterViewModel(),
    child: CounterPage(),
  ));
}
