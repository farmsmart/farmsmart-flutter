import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/data/model/articles_directory_entity.dart';

class FetchArticleDirectoryAction {
  FetchArticleDirectoryAction();
}

class UpdateArticleDirectoryAction {
  ArticlesDirectoryEntity articlesList;
  UpdateArticleDirectoryAction(this.articlesList);
}

class GoToArticleDetailAction {
  ArticleEntity article;
  GoToArticleDetailAction(this.article);
}