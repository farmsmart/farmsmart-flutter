import 'package:farmsmart_flutter/data/model/article_entity.dart';

class UpdateArticlesAction {
  List<ArticleEntity> articles;
  UpdateArticlesAction(this.articles);
}

class FetchArticlesAction {
  FetchArticlesAction();
}
