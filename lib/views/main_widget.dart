import 'package:flutter/material.dart';
import 'package:iwangui/viewmodels/main_viewmodel.dart';
import 'package:provider/provider.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Align(
          alignment: Alignment.center,
          child: Consumer<CounterViewModel>(builder: (context, viewModel, child) =>
            Column(mainAxisAlignment: MainAxisAlignment.center, spacing: 15,
            children: <Widget>[
              Text("Count: ${viewModel.count}",style: TextStyle(fontSize: 25),),
              ElevatedButton(onPressed: viewModel.increment,
                style: ElevatedButton.styleFrom(fixedSize: Size(250,40)),
                child: Text("Increment", style: TextStyle(fontSize: 20)))
            ],
          )
          ))
      ),
    );
  }
}