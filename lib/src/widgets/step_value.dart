import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:three_x_plus_1/three_x_plus_1.dart';

class StepValue extends StatefulWidget {
  StepValue({
    Key? key,
  }) : super(key: key);

  @override
  _StepValueState createState() => _StepValueState();
}

class _StepValueState extends State<StepValue> {
  final ScrollController _scrollController = ScrollController();
  final List<int> _steps = [];
  final List<StreamSubscription> _subscriptions = [];

  late MathBloc _mathBloc;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _mathBloc = context.read<MathBloc>();

    _subscriptions.add(
      _mathBloc.executeStream.stream.listen(
        (executing) {
          _timer?.cancel();
          _timer = null;

          if (executing == true) {
            _steps.clear();
          } else {
            _timer = Timer(
              const Duration(milliseconds: 300),
              () => _scrollController.jumpTo(
                _scrollController.position.maxScrollExtent,
              ),
            );
          }
          if (mounted == true) {
            setState(() {});
          }
        },
      ),
    );

    _subscriptions.add(
      _mathBloc.mathStream.stream.listen(
        (value) {
          _steps.add(value);

          _scrollController.jumpTo(
            _scrollController.position.maxScrollExtent,
          );

          if (mounted == true) {
            setState(() {});
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _subscriptions.forEach((sub) => sub.cancel());

    _timer?.cancel();
    _timer = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemBuilder: (context, index) => Text(
        index != _steps.length - 1
            ? '${_steps[index]}, '
            : _steps[index].toString(),
        style: [4, 2, 1].contains(_steps[index])
            ? TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              )
            : null,
      ),
      itemCount: _steps.length,
      scrollDirection: Axis.horizontal,
    );
  }
}
