import 'package:farmsmart_flutter/ui/playground/data/playground_tasks_datasource.dart';
import 'package:farmsmart_flutter/ui/playground/data/playground_atom_datasource.dart';
import 'package:farmsmart_flutter/ui/playground/playground_view.dart';
import 'package:farmsmart_flutter/ui/playground/playground_widget.dart';

class PlaygroundDataSource {
  List<PlaygroundWidget> getList() {
    return [
          PlaygroundWidget(
            title: 'All atoms',
            child: PlaygroundView(
                widgetList: PlayGroundAtomDataSource().getList(),
            ),
          ),
        ] +
        PlayGroundTasksDataSource().getList();
  }
}
