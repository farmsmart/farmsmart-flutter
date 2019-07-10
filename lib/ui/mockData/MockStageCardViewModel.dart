import 'package:farmsmart_flutter/ui/common/MockString.dart';
import 'package:farmsmart_flutter/ui/common/stage_card.dart';
import 'package:flutter/material.dart';

class MockStageCardViewModel {
  static StageCardViewModel buildUpcomingState() {
    return StageCardViewModel(
      stageNumber: _mockStage.random(),
      stageTitle: _mockTitle.random(),
      actionButton: () {},
      actionButtonText: _mockActionButtonText.random(),
      stageStatusTitle: 'Upcoming'
    );
  }

  static StageCardViewModel buildInProgressState() {
    return StageCardViewModel(
        stageNumber: _mockStage.random(),
        stageTitle: _mockTitle.random(),
        actionButton: () {},
        actionButtonText: _mockActionButtonText.random(),
        stageStatusTitle: 'In Progress'
    );
  }

  static StageCardViewModel buildCompleteState() {
    return StageCardViewModel(
        stageNumber: _mockStage.random(),
        stageTitle: _mockTitle.random(),
        dogTagIcon: Icons.check,
        actionButton: () {},
        actionButtonText: _mockActionButtonText.random(),
        stageStatusTitle: 'Complete'
    );
  }
}

MockString _mockTitle = MockString(library: [
  "Preparation with large text ",
  "Planting with large text",
  "Maintenance with large text",
  "Harvesting with large text ",
  "Next Step with large text",
]);

MockString _mockStage = MockString(library: [
  "Stage 1 ",
  "Stage 2 ",
  "Stage 3 ",
  "Stage 4 ",
]);

MockString _mockStageStatus = MockString(library: [
  "Complete",
  "Upcoming",
  "In Progress",
]);

MockString _mockActionButtonText = MockString(library: [
  "Mark as Complete",
  "Begin Stage",
  "Revert to In Progress",
]);

