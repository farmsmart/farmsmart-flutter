import 'package:farmsmart_flutter/data/bloc/article/ArticleListProvider.dart';
import 'package:farmsmart_flutter/data/repositories/implementation/MockArticlesRepository.dart';
import 'package:farmsmart_flutter/ui/discover/ArticleList.dart';
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
      PlaygroundWidget(title: "FARM-280 Update Discover", child:
          ArticleList(
              viewModelProvider: ArticleListProvider( title: "Test",
                  repository: MockArticlesRepository(articleCount: 2000)))
      )
    ];
  }
}
