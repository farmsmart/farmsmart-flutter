import 'package:farmsmart_flutter/data/repositories/articles_directory_repository.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/redux/home/discover/discover_actions.dart';
import 'package:redux/redux.dart';

class DiscoverMiddleWare extends MiddlewareClass<AppState> {
  @override
  Future call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if(action is FetchArticleDirectoryAction) {
        var articlesDirectory = await ArticlesDirectoryRepository.get().getDirectory();
        articlesDirectory = await ArticlesDirectoryRepository.get().getListOfArticles(articlesDirectory);
        store.dispatch(UpdateArticleDirectoryAction(articlesDirectory));
    }
    next(action);
  }
}