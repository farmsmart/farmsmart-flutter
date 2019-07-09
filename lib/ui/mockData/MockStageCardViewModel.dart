import 'package:farmsmart_flutter/ui/common/MockString.dart';
import 'package:farmsmart_flutter/ui/common/stage_card.dart';

class MockStageCardViewModel {
  static StageCardViewModel buildWithText() {
    return StageCardViewModel(
        stageNumber: _mockStage.random(),
        stageTitle: _mockTitle.random(),
        stageStatus: StageStatus(
          stage: Stage.complete,
          stageStatusText: _mockStageStatus.random(),
          actionText: 'Revert to In Progress',
          actionButton: () {},
        ));
  }
}

MockString _mockTitle = MockString(library: [
  "Preparation",
  "Planting",
  "Maintenance",
  "Harvesting",
  "Next Steps",
]);

MockString _mockStage = MockString(library: [
  "Stage 1",
  "Stage 2",
  "Stage 3",
  "Stage 4",
]);

MockString _mockStageStatus = MockString(library: [
  "Complete",
  "Upcoming",
  "In Progress",
]);
