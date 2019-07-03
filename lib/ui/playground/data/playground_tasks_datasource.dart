import 'package:farmsmart_flutter/ui/playground/playground_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:farmsmart_flutter/ui/playground/data/playground_data_source.dart';

class PlayGroundTasksDataSource implements PlaygroundDataSource {
  @override
  List<PlaygroundWidget> getList() {
    return [
      //Add Your tasks here
      PlaygroundWidget(
        title: 'TASK FARM-402 Test playground widget',
        child: Text('Test play ground'),
      ),
      /* Template
      PlaygroundWidget(
        title: '#TASK NAME#',
        child: YourWidget(),
      ),*/
    ];
  }
}
