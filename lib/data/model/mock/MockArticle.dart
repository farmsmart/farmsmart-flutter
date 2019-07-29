import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/data/model/mock/MockDate.dart';
import 'package:farmsmart_flutter/data/model/mock/MockEntity.dart';
import 'package:farmsmart_flutter/data/repositories/MockStrings.dart';
import 'package:farmsmart_flutter/data/repositories/image/implementation/MockImageEntity.dart';
import 'package:farmsmart_flutter/model/enums.dart';

final _mockDate = MockDate();

class MockArticle extends MockEntity<ArticleEntity> {
   ArticleEntity build() {
    final entity = ArticleEntity(
      id: mockPlainText.identifier(),
      content: mockRichText.random(),
      status: Status.PUBLISHED,
      summary: mockPlainText.random(),
      title: mockTitleText.random(),
      published: _mockDate.randomYearAgo(),
    );
    entity.related = MockArticleEntityCollection();
    entity.images = MockImageEntityCollection();
    return entity;
  }
  
  ArticleEntity buildStage() {
    final entity = ArticleEntity(
      id: mockPlainText.identifier(),
      content: mockRichTextNoImage.random(),
      status: Status.PUBLISHED,
      summary: mockPlainText.random(),
      title: mockTitleText.random(),
      published: _mockDate.randomYearAgo(),
    );
    entity.related = MockArticleEntityCollection();
    entity.images = null;
    return entity;
  }

}

MockArticle _articleBuilder = MockArticle();
class MockArticleEntityCollection extends MockEntityCollection<ArticleEntity> {
  MockArticleEntityCollection() : super(_articleBuilder);
}
