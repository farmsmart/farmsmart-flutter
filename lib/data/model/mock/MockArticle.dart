import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/data/model/mock/MockEntity.dart';
import 'package:farmsmart_flutter/data/repositories/MockStrings.dart';
import 'package:farmsmart_flutter/data/repositories/image/implementation/MockImageEntity.dart';
import 'package:farmsmart_flutter/model/enums.dart';

import '../EntityCollectionInterface.dart';

class MockArticle extends MockEntity<ArticleEntity> {
   ArticleEntity build() {
    final entity = ArticleEntity(
      id: mockPlainText.identifier(),
      content: mockRichText.random(),
      status: Status.PUBLISHED,
      summary: mockPlainText.random(),
      title: mockTitleText.random(),
      published: DateTime.now(),
    );
    entity.related = MockArticleEntityCollection();
    entity.images = MockImageEntityCollection();
    return entity;
  }
}

MockArticle _articleBuilder = MockArticle();

class MockArticleEntityCollection implements EntityCollection<ArticleEntity> {
  final _delay = Duration(seconds: 1);
  @override
  Future<List<ArticleEntity>> getEntities({int limit = 0}) {
    return Future.delayed(_delay, () => _articleBuilder.list());
  }
}