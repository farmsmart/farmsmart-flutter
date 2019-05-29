import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/data/model/articles_directory_entity.dart';

class FetchArticleDirectoryAction {
  FetchArticleDirectoryAction();
}

class UpdateArticleDirectoryAction {
  ArticlesDirectoryEntity articlesDirectory;
  UpdateArticleDirectoryAction(this.articlesDirectory);
}

class GoToArticleDetailAction {
  ArticleEntity article;
  GoToArticleDetailAction(this.article);
}