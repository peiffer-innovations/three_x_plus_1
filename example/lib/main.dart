import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:three_x_plus_1/three_x_plus_1.dart';

void main() {
  var mathBloc = MathBloc();

  runApp(
    Provider<MathBloc>.value(
      value: mathBloc,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '3x + 1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '3x + 1'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: <Widget>[
          Inputs(),
          Expanded(
            flex: 1,
            child: MathGraph(),
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom + 60.0,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom + 16.0,
                left: MediaQuery.of(context).padding.left + 16.0,
                right: MediaQuery.of(context).padding.right + 16.0,
                top: 16.0,
              ),
              child: StepValue(),
            ),
          ),
        ],
      ),
    );
  }
}
