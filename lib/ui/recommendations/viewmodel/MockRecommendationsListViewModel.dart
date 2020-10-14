import 'package:farmsmart_flutter/model/entities/loading_status.dart';
import 'package:farmsmart_flutter/ui/recommendations/recommendation_card/mock_recommendation_card_view_model.dart';

import 'RecommendationsListViewModel.dart';

class MockRecommendationsListViewModel {
  RecommendationsListViewModel build() {
    return RecommendationsListViewModel(
        title: "test",
        loadingStatus: LoadingStatus.SUCCESS,
        canApply: false,
        items: [
          MockRecommendationCardViewModel.buildRandomState(),
          MockRecommendationCardViewModel.buildRandomState(),
          MockRecommendationCardViewModel.buildRandomState(),
          MockRecommendationCardViewModel.buildRandomState(),
          MockRecommendationCardViewModel.buildRandomState()
        ]);
  }
}
