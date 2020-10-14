import 'package:farmsmart_flutter/ui/playground/playground_widget.dart';
import 'package:farmsmart_flutter/ui/recommendations/recommendation_card/mock_recommendation_card_view_model.dart';
import 'package:farmsmart_flutter/ui/recommendations/recommendation_card/recommendation_card.dart';
import 'package:farmsmart_flutter/ui/recommendations/recommendation_card/recommendation_card_styles.dart';
import 'playground_data_source.dart';
import 'package:flutter/widgets.dart';

class PlaygroundRecommendationCardDataSource extends PlaygroundDataSource{
  @override
  List<Widget> getList() {
    return [
      PlaygroundWidget(
        title: 'Add to plot style static',
        child: RecommendationCard(
          style: RecommendationCardStyles.buildStyle(),
          viewModel: MockRecommendationCardViewModel.buildHardCodedAddToPlotState(),
        ),
      ),
      PlaygroundWidget(
        title: 'Add to plot style',
        child: RecommendationCard(
          style: RecommendationCardStyles.buildStyle(),
          viewModel: MockRecommendationCardViewModel.buildRandomAddToPlotState(),
        ),
      ),
      PlaygroundWidget(
        title: 'Added to plot style',
        child: RecommendationCard(
          style: RecommendationCardStyles.buildStyle(),
          viewModel: MockRecommendationCardViewModel.buildRandomAddedToPlotState(),
        ),
      )
    ];
  }
}