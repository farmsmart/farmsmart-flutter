import 'package:farmsmart_flutter/data/model/NewStageEntity.dart';
import 'package:farmsmart_flutter/data/model/mock/MockString.dart';
import 'MockArticle.dart';
import 'MockEntity.dart';

MockString _identifiers = MockString();
MockArticle _articleBuilder = MockArticle();

class MockStage extends MockEntity<NewStageEntity> {
  NewStageEntity build() {
      return NewStageEntity(id: _identifiers.identifier(), article: _articleBuilder.build(), started: DateTime.now(), ended: DateTime.now());
  }
}

MockStage _stageBuilder = MockStage();
class MockArticleEntityCollection extends MockEntityCollection<NewStageEntity> {
  MockArticleEntityCollection() : super(_stageBuilder);
}
