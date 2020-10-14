import 'package:farmsmart_flutter/model/entities/mock/MockString.dart';
import 'package:farmsmart_flutter/ui/common/Alert.dart';

class MockAlertWidgetViewModel {
  static AlertViewModel build() {
    return AlertViewModel(
      titleText: _mockTitle.random(),
      detailText: _mockDetail.random(),
      cancelActionText: "Cancel",
      confirmActionText: "Yes",
      isDestructive: false,
      confirmAction: () => _mockAction(),
    );
  }

  static AlertViewModel buildDestructive() {
    return AlertViewModel(
        titleText: "Delete Profile",
        detailText: "Are you sure you want to delete your profile? Doing so will erase all data and this action cannot be undone.",
        cancelActionText: "Cancel",
        confirmActionText: "Delete",
        isDestructive: true,
        confirmAction: () => _mockAction(),
    );
  }

  static _mockAction() {
  print("Should be the correct action");
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

