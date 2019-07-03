import 'package:farmsmart_flutter/ui/playground/playground_widget.dart';
import 'package:flutter/widgets.dart';

class PlayGroundTasksDataSource {
  List<PlaygroundWidget> getList() {
    return [
      //Add Your tasks here
      PlaygroundWidget(
        title: 'TASK FARM-402 Test playground widget',
        child: Text('Test play ground'),
      )
    ];
  }
}
