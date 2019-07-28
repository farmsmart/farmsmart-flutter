import 'dart:math';

import 'package:farmsmart_flutter/data/model/crop_entity.dart';

import '../PlotEntity.dart';
import 'MockCrop.dart';
import 'MockDate.dart';
import 'MockEntity.dart';
import 'MockStage.dart';
import 'MockString.dart';

MockString _identifiers = MockString();
MockStage _mockStage = MockStage();
MockString _titles = MockString(
    library: ["TEA", "Sugarcane", "Maize", "Mirra", "PYRETHRUM", "Coffee"]);
MockDate _dates = MockDate();

class MockPlotEntity extends MockEntity<PlotEntity> {
  final Random _rand;

  MockPlotEntity({int seed}) : this._rand = Random(seed);

  PlotEntity build() {
    final entity = PlotEntity(
      id: _identifiers.identifier(),
      title: _titles.random(),
      crop: MockCrop.build(),
      score: 0.5,
      stages: _mockStage.sequence(
          starting: _dates.randomYearAgo(),
          ending: _dates.randomMonthAgo(),
          inProgress: _rand.nextBool()),
    );
    return entity;
  }

  Future<PlotEntity> buildWith(CropEntity crop) {
    if (crop == null) {
      return Future.value(build());
    }
    return crop.stageArticles.getEntities(limit: 10).then((articles) {
        final stages = articles.map((article) {
            return MockStage().buildNewFromArticle(article);
        }).toList();
        return PlotEntity(
        id: _identifiers.identifier(),
        title: crop.name,
        crop: crop,
        score: 0.5,
        stages: stages);
    });        
    
  }
}
