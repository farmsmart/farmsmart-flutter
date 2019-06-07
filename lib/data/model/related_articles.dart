import 'package:farmsmart_flutter/data/model/article_entity.dart';

abstract class IsRelatedArticlesEntity {
  List<ArticleEntity> getRelatedArticles() {
    return null;
  }
}