import 'package:flutter/material.dart';
import 'package:iwangui/viewmodels/main_viewmodel.dart';
import 'package:provider/provider.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CounterViewModel>();

    return MaterialApp(
      home: Scaffold(
        body: Align(alignment: Alignment.center,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, spacing: 15,
            children: <Widget>[
              Text("Count: ${viewModel.count}",style: TextStyle(fontSize: 25),),
              ElevatedButton(onPressed: viewModel.increment, child: Text("Increment", style: TextStyle(fontSize: 20)), style: ElevatedButton.styleFrom(fixedSize: Size(250,40)))
            ],
          ))
      ),
    );
  }
}