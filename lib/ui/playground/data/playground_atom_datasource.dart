import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/ui/playground/data/playground_data_source.dart';

class PlayGroundAtomDataSource implements PlaygroundDataSource {
  @override
  List<Widget> getList() {
    return [
      //Add your atoms here
      Text('Atom widget 1'),
      Card(child: Text('Atom widget 2')),
      Text('Atom widget 4'),
    ];
  }
}
