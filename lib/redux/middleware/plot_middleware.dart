// Middleware in charge of act upon myPlot actions that require network data.

import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/data/repositories/articles_directory_repository.dart';
import 'package:farmsmart_flutter/data/repositories/plot_repository.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/redux/home/discover/discover_actions.dart';
import 'package:farmsmart_flutter/redux/home/myPlot/my_plot_actions.dart';
import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';

class MyPlotMiddleWare extends MiddlewareClass<AppState>{
  @override
  Future call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if(action is FetchCropListAction) {
      Stopwatch sw = new Stopwatch();
      sw.start();
      var listOfCrops = await PlotRepository.get().getListOfCrops();
      debugPrint('getListOfCrops() ${sw.elapsed.inMilliseconds} ms ');
      sw.reset();
      Future fetchStageFuture = PlotRepository.get().getListOfCropStages(listOfCrops);
      Future fetchImageFuture = PlotRepository.get().getListOfCropsWithImages(listOfCrops);
      await Future.wait([fetchStageFuture, fetchImageFuture]);
      debugPrint('getStagesAndImages() ${sw.elapsed.inMilliseconds} ms ');
      sw.stop();
      debugPrint('Fetch crop complete.');
      store.dispatch(UpdateCropListAction(listOfCrops));
    }

    if (action is GoToRelatedArticleDetail) {
      store.dispatch(GoToArticleDetailAction(null));
      ArticleEntity articleWithRelated = await ArticlesDirectoryRepository.get().getListOfRelatedArticles(action.article);
      articleWithRelated.relatedArticles = await ArticlesDirectoryRepository.get().getListOfArticlesWithImages(articleWithRelated.relatedArticles);
      store.dispatch(UpdateRelatedArticlesAction(action.article));
    }

    next(action);
  }
}