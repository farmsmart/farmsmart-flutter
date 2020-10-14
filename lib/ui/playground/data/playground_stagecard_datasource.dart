import 'playground_data_source.dart';
import 'package:flutter/widgets.dart';
import 'package:farmsmart_flutter/ui/common/stage_card.dart';
import 'package:farmsmart_flutter/ui/mockData/MockStageCardViewModel.dart';
import 'package:farmsmart_flutter/ui/playground/styles/stage_card_styles.dart';

class PlaygroundStageCardDataSource extends PlaygroundDataSource{
  @override
  List<Widget> getList() {
    return [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: StageCard(
          viewModel: MockStageCardViewModel.buildCompleteState(),
          style: StageCardStyles.buildCompleteStageStyle(),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: StageCard(
          viewModel: MockStageCardViewModel.buildInProgressState(),
          style: StageCardStyles.buildInProgressStageStyle(),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: StageCard(
          viewModel: MockStageCardViewModel.buildUpcomingState(),
          style: StageCardStyles.buildUpcomingStageStyle(),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: StageCard(
          viewModel: MockStageCardViewModel.buildRandom(),
          style: StageCardStyles.buildUpcomingStageStyle(),
        ),
      ),
    ];
  }

}