import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/data/repositories/articles_repository.dart';
import 'package:farmsmart_flutter/redux/home/discover/discover_actions.dart';
import 'package:redux/redux.dart';

class DiscoverMiddleWare extends MiddlewareClass<AppState> {
  @override
  Future call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if(action is FetchArticleListAction) {
        var listOfArticles = await ArticlesRepository.get().getListOfArticles();
        listOfArticles = await ArticlesRepository.get().getListOfArticlesWithImages(listOfArticles);
        store.dispatch(UpdateArticleListAction(listOfArticles));
    }

    next(action);
  }
}