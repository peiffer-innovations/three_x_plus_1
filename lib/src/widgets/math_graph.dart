import 'dart:async';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:three_x_plus_1/three_x_plus_1.dart';

class MathGraph extends StatefulWidget {
  MathGraph({
    Key? key,
  }) : super(key: key);

  @override
  _MathGraphState createState() => _MathGraphState();
}

class _MathGraphState extends State<MathGraph> {
  final List<XY> _steps = [];
  final List<StreamSubscription> _subscriptions = [];

  late MathBloc _mathBloc;

  @override
  void initState() {
    super.initState();

    _mathBloc = context.read<MathBloc>();

    _subscriptions.add(
      _mathBloc.executeStream.stream.listen(
        (executing) {
          if (executing == true) {
            _steps.clear();
            if (mounted == true) {
              setState(() {});
            }
          }
        },
      ),
    );

    _subscriptions.add(
      _mathBloc.mathStream.stream.listen(
        (value) {
          _steps.add(XY(
            x: _steps.length,
            y: value,
          ));
          if (mounted == true) {
            setState(() {});
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _subscriptions.forEach((sub) => sub.cancel());

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return charts.LineChart(
      [
        charts.Series<XY, int>(
          data: _steps.reversed.take(40).toList().reversed.toList(),
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (xy, _) => xy.x,
          id: '3x + 1',
          measureFn: (xy, _) => xy.y,
        ),
      ],
      animate: false,
      behaviors: [
        // charts.PanBehavior(),
        charts.PanAndZoomBehavior(),
      ],
      defaultRenderer: charts.LineRendererConfig(
        includePoints: true,
      ),
    );
  }
}

class XY {
  XY({
    required this.x,
    required this.y,
  });

  final int x;
  final int y;
}
