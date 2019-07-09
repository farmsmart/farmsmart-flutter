import 'package:farmsmart_flutter/data/model/EntityCollectionInterface.dart';
import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/data/model/mock/MockArticle.dart';
import 'package:farmsmart_flutter/data/repositories/MockStrings.dart';
import 'package:farmsmart_flutter/data/repositories/crop/CropRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/enums.dart';
import 'package:farmsmart_flutter/utils/MockString.dart';

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



class MockCropRepository implements CropRepositoryInterface {

  final _list = MockCrop.list();
  final _delay = Duration(seconds: 1);
  final _streamEventCount = 50;

  @override
  Future<List<CropEntity>> getCollection(EntityCollection<CropEntity> collection) {
    return Future.delayed(_delay, () => _list);
  }

  @override
  Future<CropEntity> getSingle(String uri) {
    final result =  _list.reduce((left, right) {
        return (left.id == uri) ? left : (right.id == uri) ? right : null;
    });
    return Future.delayed(_delay, () => result);
  }

  @override
  Stream<CropEntity> observe(String uri) {
    var sequence;
    for (var i = 0; i < _streamEventCount; i++) {
      sequence.add(Future.delayed(_delay, () => MockCrop.build()));
    }
    return Stream.fromFutures(sequence);
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