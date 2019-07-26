import 'dart:math';

import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/ui/common/recommendation_card/mock_recommendation_card_view_model.dart';

import 'RecommendationsListViewModel.dart';

class MockRecommendationsListViewModel {
  final Random _rand = Random(0);
  RecommendationsListViewModel build() {
    return RecommendationsListViewModel(
        title: "test",
        loadingStatus: LoadingStatus.SUCCESS,
        canApply: false,
        isHeroItem: _randomBool,
        items: [
          MockRecommendationCardViewModel.buildRandomState(),
          MockRecommendationCardViewModel.buildRandomState(),
          MockRecommendationCardViewModel.buildRandomState(),
          MockRecommendationCardViewModel.buildRandomState(),
          MockRecommendationCardViewModel.buildRandomState()
        ]);
  }
  bool _randomBool(int index){
    return _rand.nextBool();
  }
}
