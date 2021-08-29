import 'dart:async';

class MathBloc {
  final StreamController<bool> executeStream =
      StreamController<bool>.broadcast();
  final StreamController<int> mathStream = StreamController<int>.broadcast();

  bool _executing = false;

  void dispose() {
    executeStream.close();
    mathStream.close();
  }

  void cancel() {
    if (_executing == true) {
      _executing = false;
      executeStream.add(_executing);
    }
  }

  Future<void> execute({
    Duration delay = const Duration(milliseconds: 200),
    required int value,
  }) async {
    if (value == 0) {
      throw Exception('[ERROR]: value must be greater than or equal to 1.');
    }

    if (_executing == true) {
      cancel();
    }

    _executing = true;
    executeStream.add(_executing);
    var calculated = value;
    while (calculated != 1 && _executing) {
      await Future.delayed(delay);

      if (_executing == true) {
        if (calculated % 2 == 1) {
          calculated = (calculated * 3) + 1;
        } else {
          calculated = calculated ~/ 2;
        }

        mathStream.add(calculated);
      }
    }

    cancel();
  }
}
