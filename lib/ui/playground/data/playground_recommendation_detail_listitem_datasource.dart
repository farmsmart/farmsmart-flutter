import 'package:farmsmart_flutter/ui/common/recommendation_detail_listitem/mock_recommendation_detail_listitem_view_model.dart';
import 'package:farmsmart_flutter/ui/common/recommendation_detail_listitem/recommendation_detail_listitem.dart';
import 'package:farmsmart_flutter/ui/common/recommendation_detail_listitem/recommendation_detail_listitem_styles.dart';
import 'package:farmsmart_flutter/ui/playground/data/playground_data_source.dart';
import 'package:farmsmart_flutter/ui/playground/playground_widget.dart';
import 'package:flutter/widgets.dart';

class PlaygroundRecommendationDetailListItemDatasource
    extends PlaygroundDataSource {
  @override
  List<Widget> getList() {
    return [
      PlaygroundWidget(
        title: 'Real example',
        child: RecommendationDetailListItem(
          style: RecommendationDetailListItemStyles.build(),
          viewModel:
              MockRecommendationDetailListItemViewModel.buildForTesting(),
        ),
      ),
      PlaygroundWidget(
        title: 'With large colors list',
        child: RecommendationDetailListItem(
          style: RecommendationDetailListItemStyles.build(),
          viewModel: MockRecommendationDetailListItemViewModel
              .buildWithLargeColorList(),
        ),
      ),
      PlaygroundWidget(
        title: 'With large text and colors list',
        child: RecommendationDetailListItem(
          style: RecommendationDetailListItemStyles.build(),
          viewModel: MockRecommendationDetailListItemViewModel
              .buildWithLargeTextAndColorList(),
        ),
      ),
      PlaygroundWidget(
        title: 'Without color list',
        child: RecommendationDetailListItem(
          style: RecommendationDetailListItemStyles.build(),
          viewModel:
              MockRecommendationDetailListItemViewModel.buildWithoutColorList(),
        ),
      ),
      PlaygroundWidget(
        title: 'With short color list',
        child: RecommendationDetailListItem(
          style: RecommendationDetailListItemStyles.build(),
          viewModel: MockRecommendationDetailListItemViewModel
              .buildWithShortColorList(),
        ),
      ),
    ];
  }
}
