import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/data/model/articles_directory_entity.dart';
import 'package:farmsmart_flutter/data/repositories/articles_directory_repository.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/redux/home/discover/discover_actions.dart';
import 'package:redux/redux.dart';

class DiscoverMiddleWare extends MiddlewareClass<AppState> {
  @override
  Future call(
      Store<AppState> store, dynamic action, NextDispatcher next) async {
    if(action is FetchArticleDirectoryAction) {
      ArticlesDirectoryEntity directory = await ArticlesDirectoryRepository.get().getArticlesWithImages();
      store.dispatch(UpdateArticleDirectoryAction(directory));
    }

    if(action is FetchSingleArticleAction) {
      ArticleEntity article = await ArticlesDirectoryRepository.get().getSingleArticle(action.articleID);
      store.dispatch(GoToArticleDetailAction(article));
    }

    if (action is FetchRelatedArticlesAction) {
      store.dispatch(GoToArticleDetailAction(null));
      ArticleEntity article = await ArticlesDirectoryRepository.get().getRelatedArticles(action.articleWithRelated);
      store.dispatch(UpdateRelatedArticlesAction(article));
    }

    next(action);
  }
}
