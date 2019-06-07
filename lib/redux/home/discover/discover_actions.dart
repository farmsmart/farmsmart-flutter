import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/data/model/articles_directory_entity.dart';

class FetchArticleDirectoryAction {
  FetchArticleDirectoryAction();
}

class UpdateArticleDirectoryAction {
  ArticlesDirectoryEntity articlesDirectory;
  UpdateArticleDirectoryAction(this.articlesDirectory);
}

class UpdateRelatedArticlesAction {
  ArticleEntity articleWithRelated;
  UpdateRelatedArticlesAction(this.articleWithRelated);
}

class GoToArticleDetailAction {
  ArticleEntity article;
  GoToArticleDetailAction(this.article);
}

class FetchSingleArticleAction {
  String articleID;
  FetchSingleArticleAction(this.articleID);
}

class FetchRelatedArticlesAction {
  ArticleEntity articleWithRelated;
  FetchRelatedArticlesAction(this.articleWithRelated);
}