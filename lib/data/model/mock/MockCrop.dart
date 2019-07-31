import 'package:farmsmart_flutter/data/model/mock/MockString.dart';
import 'package:farmsmart_flutter/data/repositories/MockStrings.dart';
import 'package:farmsmart_flutter/data/repositories/image/implementation/MockImageEntity.dart';
import 'package:farmsmart_flutter/model/enums.dart';

import '../crop_entity.dart';
import 'MockArticle.dart';

class MockCrop {
  static CropEntity build() {
    final name =  plants.random();
    final entity = CropEntity(id: name,
    article: MockArticle().buildCrop(name),
    companionPlants: plants.list(),
    complexity: CropComplexity.BEGINNER,
    cropsInRotation: plants.list(),
    cropType: CropType.SINGLE,
    name: name,
    nonCompanionPlants: plants.list(),
    profitability: LoHi.MEDIUM,
    setupCost: LoHi.MEDIUM,
    soilType: _soil.list(),
    waterRequirement: LoHi.MEDIUM,
    );
    entity.stageArticles = MockArticleEntityCollection();
    entity.images = MockImageEntityCollection();
    return entity;
  }

  static List<CropEntity> list({int count = 50}) {
    List<CropEntity> articles = [];
    for (var i = 0; i < count; i++) {
      articles.add(build());
    }
    return articles;
  }
}

// Mock Strings --------------

MockString _soil = MockString(library: [
  "Soil A",
  "Soil B",
  "Soil C",
  "Soil D",
  "Soil E",
  "Soil F"
]);