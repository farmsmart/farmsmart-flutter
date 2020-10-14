import 'package:farmsmart_flutter/model/entities/mock/MockString.dart';
import 'package:farmsmart_flutter/model/repositories/MockStrings.dart';
import 'package:farmsmart_flutter/model/repositories/image/implementation/MockImageEntity.dart';
import '../crop_entity.dart';
import '../enums.dart';
import 'MockArticle.dart';

class MockCrop {
  static CropEntity build({String cropName}) {
    final name = cropName ?? plants.random();
    final entity = CropEntity(uri: name,
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

  static List<CropEntity> uniqueList(){
    List<CropEntity> items = [];
    final allPlants = plants.libarary();
    for (var i = 0; i < allPlants.length; i++) {
      items.add(build(cropName: allPlants[i]));
    }
    return items;
  }

  static List<CropEntity> list({int count = 50}) {
    List<CropEntity> items = [];
    for (var i = 0; i < count; i++) {
      items.add(build());
    }
    return items;
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