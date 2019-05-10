import 'package:farmsmart_flutter/data/model/article_entity.dart';

class FetchArticleListAction {
  FetchArticleListAction();
}

class UpdateArticleListAction {
  List<ArticleEntity> articlesList;
  UpdateArticleListAction(this.articlesList);
}

class GoToArticleDetailAction {
  ArticleEntity article;
  GoToArticleDetailAction(this.article);
}