import 'package:farmsmart_flutter/ui/common/AlertWidget.dart';
import 'package:farmsmart_flutter/ui/common/MockString.dart';

class MockAlertWidgetViewModel {
  static AlertWidgetViewModel build() {
    return AlertWidgetViewModel(
      titleText: _mockTitle.random(),
      detailText: _mockDetail.random(),
      leftActionText: "Cancel",
      rightActionText: "Yes",
      isDestructive: false,
      rightActionFunction: () => _mockAction(),
    );
  }

  static AlertWidgetViewModel buildDestructive() {
    return AlertWidgetViewModel(
        titleText: "Delete Profile",
        detailText: "Are you sure you want to delete your profile? Doing so will erase all data and this action cannot be undone.",
        leftActionText: "Cancel",
        rightActionText: "Delete",
        isDestructive: true,
        rightActionFunction: () => _mockAction(),
    );
  }

  static _mockAction() {
    print("This should be the correct action");
  }
}

MockString _mockTitle = MockString(library: [
  "Mark as Complete",
  "Begin Stage 2",
]);

MockString _mockDetail = MockString(library: [
  "Are you sure you want to mark Stage 2 – Planting as Complete?",
  "Are you sure you want to beging Stage 2 – Planting?",
]);

