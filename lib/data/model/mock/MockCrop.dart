import 'package:farmsmart_flutter/data/model/mock/MockString.dart';
import 'package:farmsmart_flutter/data/repositories/MockStrings.dart';
import 'package:farmsmart_flutter/data/repositories/image/implementation/MockImageEntity.dart';
import 'package:farmsmart_flutter/model/enums.dart';

import '../crop_entity.dart';
import 'MockArticle.dart';

class MockCrop {
  static CropEntity build() {
    final entity = CropEntity(id: mockPlainText.identifier(),
    companionPlants: _plants.list(),
    complexity: CropComplexity.BEGINNER,
    content: mockRichText.random(),
    cropsInRotation: _plants.list(),
    cropType: CropType.SINGLE,
    name: _plants.random(),
    nonCompanionPlants: _plants.list(),
    profitability: LoHi.MEDIUM,
    setupCost: LoHi.MEDIUM,
    soilType: _soil.list(),
    summary: mockPlainText.random(length: 1000),
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

MockString _plants = MockString(library: [
  "Plant A",
  "Plant B",
  "Plant C",
  "Plant D",
  "Plant E",
  "Plant F"
]);

MockString _soil = MockString(library: [
  "Soil A",
  "Soil B",
  "Soil C",
  "Soil D",
  "Soil E",
  "Soil F"
]);