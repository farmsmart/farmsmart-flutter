import 'package:farmsmart_flutter/ui/playground/data/playground_data_source.dart';
import 'package:farmsmart_flutter/ui/playground/playground_widget.dart';
import 'package:farmsmart_flutter/ui/recommendations/recommendation_detail_card/mock_recommendation_detail_card_view_model.dart';
import 'package:farmsmart_flutter/ui/recommendations/recommendation_detail_card/recommendation_detail_card.dart';
import 'package:farmsmart_flutter/ui/recommendations/recommendation_detail_card/recommendation_detail_card_styles.dart';
import 'package:flutter/widgets.dart';

class PlaygroundRecommendationDetailCardDatasource
    extends PlaygroundDataSource {
  @override
  List<Widget> getList() {
    return [
      PlaygroundWidget(
        title: 'Add to Your Plot',
        child: RecommendationDetailCard(
          style: RecommendationDetailCardStyles.build(),
          viewModel:
              MockRecommendationDetailCardViewModel.buildAddToYourPlotState(),
        ),
      ),
      PlaygroundWidget(
        title: 'Added to Your Plot',
        child: RecommendationDetailCard(
          style: RecommendationDetailCardStyles.build(),
          viewModel:
              MockRecommendationDetailCardViewModel.buildAddedToYourPlot(),
        ),
      ),
      PlaygroundWidget(
        title: 'Add to Your Plot with large strings',
        child: RecommendationDetailCard(
          style: RecommendationDetailCardStyles.build(),
          viewModel:
              MockRecommendationDetailCardViewModel.buildWithLargeStrings(),
        ),
      ),
    ];
  }
}
