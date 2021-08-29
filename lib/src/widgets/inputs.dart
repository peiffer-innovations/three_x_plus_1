import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:three_x_plus_1/three_x_plus_1.dart';

class Inputs extends StatefulWidget {
  Inputs({Key? key}) : super(key: key);

  @override
  _InputsState createState() => _InputsState();
}

class _InputsState extends State<Inputs> {
  final TextEditingController _textController = TextEditingController();

  late MathBloc _mathBloc;
  int _value = _getRandomNumber();

  static int _getRandomNumber() => Random().nextInt(10000);

  @override
  void initState() {
    super.initState();

    _mathBloc = context.read<MathBloc>();
    _textController.text = _value.toString();
  }

  @override
  void dispose() {
    super.dispose();

    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _textController,
                keyboardType: TextInputType.phone,
              ),
            ),
            IconButton(
              icon: Icon(Icons.play_arrow),
              onPressed: () => _mathBloc.execute(
                value: int.tryParse(_textController.text) ?? 1,
              ),
            ),
            IconButton(
              icon: Icon(Icons.shuffle),
              onPressed: () => setState(
                () {
                  _value = _getRandomNumber();
                  _textController.text = _value.toString();
                },
              ),
            ),
          ],
        ),
      );
}
