import 'package:farmsmart_flutter/data/model/article_entity.dart';

enum ArticleCollectionGroup {
  all,
  discovery
}

abstract class ArticleRepositoryInterface {
  Future<List<ArticleEntity>> getArticles(ArticleEntityCollection collection);
  Future<ArticleEntity> getArticle(String uri);
  Stream<ArticleEntity> observeArticle(String uri);
  Future<List<ArticleEntity>> get({ArticleCollectionGroup group = ArticleCollectionGroup.all, int limit = 0});
}
