import 'package:farmsmart_flutter/model/model/FactorEntity.dart';
import 'package:farmsmart_flutter/model/repositories/MockListRepository.dart';

abstract class RatingEngineRepositoryInterface extends MockListRepository<FactorEntity> {
    Future<List<FactorEntity>> getWeights();
    Stream<List<FactorEntity>> observeWeights();
}