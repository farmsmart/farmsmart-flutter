import 'package:farmsmart_flutter/model/model/mock/MockRecommendation.dart';

import '../RatingEngineRepositoryInterface.dart';

class MockRatingEngineRepository implements RatingEngineRepositoryInterface {
  @override
  Future<Map<String, RatingInfo>> getRatingInfo() {
    final inputFactors = harryInputFactors.map((subject,value){
      return MapEntry(subject, RatingInfo(harryWeights[subject], value));
    });
    return Future.value(inputFactors);
  }

  @override
  Future<Map<String, RatingInfo>> observeRatingInfo() {
    // TODO: implement observeRatingInfo
    return null;
  }
  


}
