import 'dart:math';
import 'package:farmsmart_flutter/ui/common/CircularProgress.dart';
import 'package:flutter/widgets.dart';

class MockCircularProgressViewModel {
  static CircularProgressViewModel build() {
    return CircularProgressViewModel(
        initialValue: 10.0, content: _mockContent());
  }
}

double _mockDoubleNumber() {
  List<double> list = [5.0, 10.0, 35.0, 50.0, 75.0, 100.0];
  final _random = Random();
  double element = list[_random.nextInt(list.length)];

  return element;
}

List<Widget> _mockContent() {
  List<Widget> listBuilder = [];
  listBuilder.add(Center(
    child: Text("10%"),
  ));
  return listBuilder;
}
