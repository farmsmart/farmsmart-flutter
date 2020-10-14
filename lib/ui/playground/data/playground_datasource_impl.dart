import 'package:farmsmart_flutter/ui/playground/data/playground_tasks_datasource.dart';
import 'package:farmsmart_flutter/ui/playground/data/playground_atom_datasource.dart';
import 'package:farmsmart_flutter/ui/playground/playground_view.dart';
import 'package:farmsmart_flutter/ui/playground/playground_widget.dart';
import 'package:farmsmart_flutter/ui/playground/data/playground_data_source.dart';

class PlaygroundDataSourceImpl implements PlaygroundDataSource {
  @override
  List<PlaygroundWidget> getList() {
    return [
          PlaygroundWidget(
            title: 'Atoms',
            child: PlaygroundView(
              widgetList: PlayGroundAtomDataSource().getList(),
            ),
          ),
        ] +
        PlayGroundTasksDataSource().getList();
  }
}
