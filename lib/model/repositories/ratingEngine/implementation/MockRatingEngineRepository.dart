import 'dart:async';

import 'package:farmsmart_flutter/model/entities/mock/MockRecommendation.dart';

import '../RatingEngineRepositoryInterface.dart';

class MockRatingEngineRepository implements RatingEngineRepositoryInterface {
  final _streamController =
      StreamController<Map<String, RatingInfo>>.broadcast();

  @override
  Future<Map<String, RatingInfo>> getRatingInfo() {
    final inputFactors = harryInputFactors.map((subject, value) {
      return MapEntry(subject, RatingInfo(harryWeights[subject], value));
    });
    _streamController.sink.add(inputFactors);
    return Future.value(inputFactors);
  }

  @override
  Stream<Map<String, RatingInfo>> observeRatingInfo() {
    return _streamController.stream;
  }

  void dispose() {
    _streamController.sink.close();
    _streamController.close();
  }

  @override
  Future<Map<String,String>> ratingNameLookup() {
    return Future.value({});
  }
}
