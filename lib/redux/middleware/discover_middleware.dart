import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/data/model/articles_directory_entity.dart';
import 'package:farmsmart_flutter/data/repositories/ArticleRepositoryInterface.dart';
import 'package:farmsmart_flutter/data/repositories/articles_directory_repository.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/redux/home/discover/discover_actions.dart';
import 'package:redux/redux.dart';

class DiscoverMiddleWare extends MiddlewareClass<AppState> {

  final ArticleRepositoryInterface _articleRepo;

  DiscoverMiddleWare(ArticleRepositoryInterface repository) : _articleRepo = repository;

  @override
  Future call(
      Store<AppState> store, dynamic action, NextDispatcher next) async {
    if(action is FetchArticlesAction) {
      final featureArticles = await _articleRepo.get();
      store.dispatch(UpdateArticlesAction(featureArticles));
    }
    next(action);
  }
}
