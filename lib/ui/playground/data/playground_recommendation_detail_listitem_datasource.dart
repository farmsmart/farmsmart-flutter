import 'package:farmsmart_flutter/ui/crop/CropInfoListItem.dart';
import 'package:farmsmart_flutter/ui/crop/cropInfoListItem/mockCropInfoListItemStyles.dart';
import 'package:farmsmart_flutter/ui/crop/cropInfoListItemStyles.dart';
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
        child: CropInfoListItem(
          style: RecommendationDetailListItemStyles.build(),
          viewModel:
              MockRecommendationDetailListItemViewModel.buildForTesting(),
        ),
      ),
      PlaygroundWidget(
        title: 'With large colors list',
        child: CropInfoListItem(
          style: RecommendationDetailListItemStyles.build(),
          viewModel: MockRecommendationDetailListItemViewModel
              .buildWithLargeColorList(),
        ),
      ),
      PlaygroundWidget(
        title: 'With large text and colors list',
        child: CropInfoListItem(
          style: RecommendationDetailListItemStyles.build(),
          viewModel: MockRecommendationDetailListItemViewModel
              .buildWithLargeTextAndColorList(),
        ),
      ),
      PlaygroundWidget(
        title: 'Without color list',
        child: CropInfoListItem(
          style: RecommendationDetailListItemStyles.build(),
          viewModel:
              MockRecommendationDetailListItemViewModel.buildWithoutColorList(),
        ),
      ),
      PlaygroundWidget(
        title: 'With short color list',
        child: CropInfoListItem(
          style: RecommendationDetailListItemStyles.build(),
          viewModel: MockRecommendationDetailListItemViewModel
              .buildWithShortColorList(),
        ),
      ),
    ];
  }
}
