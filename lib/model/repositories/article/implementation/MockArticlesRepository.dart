import 'package:farmsmart_flutter/model/entities/EntityCollectionInterface.dart';
import 'package:farmsmart_flutter/model/entities/article_entity.dart';
import 'package:farmsmart_flutter/model/entities/mock/MockArticle.dart';
import '../ArticleRepositoryInterface.dart';

MockArticle _articleBuilder = MockArticle();

class MockArticlesRepository implements ArticleRepositoryInterface {
  final _articles;
  final _delay = Duration(milliseconds: 200);
  final _streamEventCount = 50;

  MockArticlesRepository({int articleCount = 1000})
      : _articles = _generateArticles(count: articleCount);

  static List<ArticleEntity> _generateArticles({int count = 1000}) {
    var articles = <ArticleEntity>[];
    for (var i = 0; i < count; i++) {
      articles.add(_articleBuilder.build());
    }
    return articles;
  }

  @override
  Future<List<ArticleEntity>> get(
      {ArticleCollectionGroup group = ArticleCollectionGroup.all,
      int limit = 0}) {
    return Future.delayed(_delay, () => _articles);
  }

  @override
  Future<ArticleEntity> getArticle(String uri) {
    return Future.delayed(_delay, () => _articleBuilder.build());
  }

  @override
  Future<List<ArticleEntity>> getArticles(EntityCollection<ArticleEntity> collection) {
    return collection.getEntities();
  }

  @override
  Stream<ArticleEntity> observeArticle(String uri) {
    var sequence;
    for (var i = 0; i < _streamEventCount; i++) {
      sequence.add(Future.delayed(_delay, () => _articleBuilder.build()));
    }
    return Stream.fromFutures(sequence);
  }
}
