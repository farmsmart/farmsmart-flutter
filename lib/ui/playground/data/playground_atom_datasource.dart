import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class PlayGroundAtomDataSource {
  List<Widget> getList() {
    return [
      //Add your atoms here
      Text('Atom widget 1'),
      Card(child: Text('Atom widget 2')),
      Text('Atom widget 4'),
    ];
  }
}
