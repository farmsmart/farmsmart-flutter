import 'package:farmsmart_flutter/model/entities/article_entity.dart';
import 'package:farmsmart_flutter/model/entities/mock/MockDate.dart';
import 'package:farmsmart_flutter/model/entities/mock/MockEntity.dart';
import 'package:farmsmart_flutter/model/repositories/MockStrings.dart';
import 'package:farmsmart_flutter/model/repositories/image/implementation/MockImageEntity.dart';

import '../enums.dart';

final _mockDate = MockDate();

class MockArticle extends MockEntity<ArticleEntity> {
  ArticleEntity build() {
    final entity = ArticleEntity(
      uri: mockPlainText.identifier(),
      content: mockRichText.random(),
      status: Status.PUBLISHED,
      summary: mockPlainText.random(),
      title: mockTitleText.random(),
      published: _mockDate.randomYearAgo(),
      externalLink: mockExternalLinks.random(),
    );
    entity.related = MockArticleEntityCollection();
    entity.images = MockImageEntityCollection();
    return entity;
  }

  ArticleEntity buildCrop(String title) {
    final entity = ArticleEntity(
      uri: mockPlainText.identifier(),
      content: mockRichTextNoImage.random(),
      status: Status.PUBLISHED,
      summary: mockPlainText.random(),
      title: title,
      published: _mockDate.randomYearAgo(),
    );
    entity.related = null;
    entity.images = MockImageEntityCollection();
    return entity;
  }

  ArticleEntity buildStage() {
    final entity = ArticleEntity(
      uri: mockPlainText.identifier(),
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

  ArticleEntity buildStageFromArticle(ArticleEntity article) {
    final entity = article;
    entity.images = null;
    return entity;
  }
}

MockArticle _articleBuilder = MockArticle();

class MockArticleEntityCollection extends MockEntityCollection<ArticleEntity> {
  MockArticleEntityCollection()
      : super(_articleBuilder);
}
