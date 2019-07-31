import 'package:farmsmart_flutter/data/model/EntityCollectionInterface.dart';
import 'package:farmsmart_flutter/data/model/article_entity.dart';

enum ArticleCollectionGroup {
  all,
  discovery,
  chatGroups
}

abstract class ArticleRepositoryInterface {
  Future<List<ArticleEntity>> getArticles(EntityCollection<ArticleEntity> collection);
  Future<ArticleEntity> getArticle(String uri);
  Stream<ArticleEntity> observeArticle(String uri);
  Future<List<ArticleEntity>> get({ArticleCollectionGroup group = ArticleCollectionGroup.all, int limit = 0});
}
