import 'package:farmsmart_flutter/model/model/FactorEntity.dart';
import 'package:farmsmart_flutter/model/model/mock/MockRecommendation.dart';
import 'package:farmsmart_flutter/model/repositories/MockListRepository.dart';

import '../RatingEngineRepositoryInterface.dart';

final _mockWeights = harryWeights;

class MockRatingEngineRepository extends MockListRepository<FactorEntity>
    implements RatingEngineRepositoryInterface {
  MockRatingEngineRepository._(
      IdentifyEntity<FactorEntity> identifyEntity, List<FactorEntity> startData)
      : super(
          identifyEntity: identifyEntity,
          startingData: startData,
        );

  factory MockRatingEngineRepository() {
    return MockRatingEngineRepository._(null, _mockWeights);
  }

  @override
  Future<List<FactorEntity>> getWeights() {
    return getList();
  }

  @override
  Stream<List<FactorEntity>> observeWeights() {
    return observeList();
  }
}
