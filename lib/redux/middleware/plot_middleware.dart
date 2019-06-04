// Middleware in charge of act upon myPlot actions that require network data.

import 'package:farmsmart_flutter/data/repositories/articles_directory_repository.dart';
import 'package:farmsmart_flutter/data/repositories/plot_repository.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/redux/home/myPlot/my_plot_actions.dart';
import 'package:redux/redux.dart';

class MyPlotMiddleWare extends MiddlewareClass<AppState>{
  @override
  Future call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if(action is FetchCropListAction) {
      var listOfCrops = await PlotRepository.get().getListOfCrops();
      listOfCrops = await PlotRepository.get().getListOfCropStages(listOfCrops);

      for (var crop in listOfCrops) {
        for(var stage in crop.stages) {
          stage = await PlotRepository.get().getListOfStageRelatedArticles(stage);
          stage.stageRelatedArticles= await ArticlesDirectoryRepository.get().getListOfArticlesWithImages(stage.stageRelatedArticles);
          }
      }

      listOfCrops = await PlotRepository.get().getListOfCropsWithImages(listOfCrops);
      store.dispatch(UpdateCropListAction(listOfCrops));
    }

    next(action);
  }
}