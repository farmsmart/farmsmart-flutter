// Middleware in charge of act upon myPlot actions that require network data.

import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/data/model/stage_entity.dart';
import 'package:farmsmart_flutter/data/repositories/articles_directory_repository.dart';
import 'package:farmsmart_flutter/data/repositories/plot_repository.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/redux/home/discover/discover_actions.dart';
import 'package:farmsmart_flutter/redux/home/myPlot/my_plot_actions.dart';
import 'package:redux/redux.dart';

class MyPlotMiddleWare extends MiddlewareClass<AppState>{
  @override
  Future call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if(action is FetchCropListAction) {
      List<CropEntity> listOfCrops = await PlotRepository.get().getArticles();
      store.dispatch(UpdateCropListAction(listOfCrops));
    }
    if (action is UpdateStageAction) {
      StageEntity stage = await ArticlesDirectoryRepository.get().getStageRelatedArticles(action.stage);
      store.dispatch(GoToStageAction(stage));
    }
    next(action);
  }
}