import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/data/repositories/discover_repository.dart';
import 'package:farmsmart_flutter/redux/home/discover/discover_actions.dart';
import 'package:redux/redux.dart';

class DiscoverMiddleWare extends MiddlewareClass<AppState> {
  @override
  Future call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if(action is FetchArticleListAction) {
        var listOfArticles = await DiscoverRepository.get().getListOfArticles();
        listOfArticles = await DiscoverRepository.get().getListOfArticlesWithImages(listOfArticles);
        store.dispatch(UpdateArticleListAction(listOfArticles));
    }

    next(action);
  }
}