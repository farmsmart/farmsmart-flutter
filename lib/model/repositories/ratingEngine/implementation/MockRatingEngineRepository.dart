import 'package:farmsmart_flutter/model/model/mock/MockRecommendation.dart';

import '../RatingEngineRepositoryInterface.dart';

class MockRatingEngineRepository implements RatingEngineRepositoryInterface {
  @override
  Future<Map<String, Map<String, Map<String, double>>>> getFactors() {
    return Future.value(harryInputFactors);
  }

  @override
  Future<Map<String, Map<String, double>>> getWeights() {
     return Future.value(harryWeights);
  }

  @override
  Stream<Map<String, Map<String, Map<String, double>>>> observeFactors() {
    return null;
  }

  @override
  Stream<Map<String, Map<String, double>>> observeWeights() {
    return null;
  }


}
