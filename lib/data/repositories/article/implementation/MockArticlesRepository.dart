import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/data/model/EntityCollectionInterface.dart';
import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/data/repositories/MockStrings.dart';
import 'package:farmsmart_flutter/model/enums.dart';
import '../ArticleRepositoryInterface.dart';

class MockArticle {
  static ArticleEntity build() {
    final entity = ArticleEntity(
      id: mockPlainText.identifier(),
      content: mockRichText.random(),
      status: Status.PUBLISHED,
      summary: mockPlainText.random(),
      title: mockTitleText.random(),
      published: Timestamp.now(),
    );
    entity.related = MockArticleEntityCollection();
    return entity;
  }
  
  static List<ArticleEntity> list({int count = 50}) {
    List<ArticleEntity> articles = [];
    for (var i = 0; i < count; i++) {
      articles.add(build());
    }
    return articles;
  }
}

class MockArticleEntityCollection implements EntityCollection<ArticleEntity> {
  final _delay = Duration(seconds: 1);
  @override
  Future<List<ArticleEntity>> getEntities({int limit = 0}) {
    return Future.delayed(_delay, () => MockArticle.list());
  }
}

class MockArticlesRepository implements ArticleRepositoryInterface {
  final _articles;
  final _delay = Duration(seconds: 1);
  final _streamEventCount = 50;

  MockArticlesRepository({int articleCount = 1000})
      : _articles = _generateArticles(count: articleCount);

  static List<ArticleEntity> _generateArticles({int count = 1000}) {
    var articles = <ArticleEntity>[];
    for (var i = 0; i < count; i++) {
      articles.add(MockArticle.build());
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
    return Future.delayed(_delay, () => MockArticle.build());
  }

  @override
  Future<List<ArticleEntity>> getArticles(EntityCollection<ArticleEntity> collection) {
    return collection.getEntities();
  }

  @override
  Stream<ArticleEntity> observeArticle(String uri) {
    var sequence;
    for (var i = 0; i < _streamEventCount; i++) {
      sequence.add(Future.delayed(_delay, () => MockArticle.build()));
    }
    return Stream.fromFutures(sequence);
  }
}
