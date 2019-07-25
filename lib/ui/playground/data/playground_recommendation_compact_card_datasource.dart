import 'package:farmsmart_flutter/ui/common/recommendation_card/mock_recommendation_card_view_model.dart';
import 'package:farmsmart_flutter/ui/common/recommendation_compact_card/recommendation_compact_card.dart';
import 'package:farmsmart_flutter/ui/common/recommendation_compact_card/recommendation_compact_card_styles.dart';
import 'package:farmsmart_flutter/ui/playground/playground_widget.dart';

import 'playground_data_source.dart';
import 'package:flutter/widgets.dart';

class PlaygroundRecommendationCompactCardDataSource extends PlaygroundDataSource{
  @override
  List<Widget> getList() {
    return [
      PlaygroundWidget(
        title: 'Add to plot style static',
        child: RecommendationCompactCard(
          style: RecommendationCompactCardStyles.buildAddToPlotStyle(),
          viewModel: MockRecommendationCardViewModel.buildHardCodedAddToPlotState(),
        ),
      ),
      PlaygroundWidget(
        title: 'Add to plot style',
        child: RecommendationCompactCard(
          style: RecommendationCompactCardStyles.buildAddToPlotStyle(),
          viewModel: MockRecommendationCardViewModel.buildRandomAddToPlotState(),
        ),
      ),
      PlaygroundWidget(
        title: 'Added to plot style',
        child: RecommendationCompactCard(
          style: RecommendationCompactCardStyles.buildAddedToPlotStyle(),
          viewModel: MockRecommendationCardViewModel.buildRandomAddedToPlotState(),
        ),
      )
    ];
  }
}