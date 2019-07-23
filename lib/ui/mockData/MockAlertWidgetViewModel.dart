import 'package:farmsmart_flutter/ui/common/AlertWidget.dart';
import 'package:farmsmart_flutter/ui/common/MockString.dart';

class MockAlertWidgetViewModel {
  static AlertWidgetViewModel build() {
    return AlertWidgetViewModel(
      titleText: _mockTitle.random(),
      detailText: _mockDetail.random(),
      cancelButtonTittle: "Cancel",
      confirmButtonTittle: "Yes",
      isDestructive: false,
    );
  }

  static AlertWidgetViewModel buildDestructive() {
    return AlertWidgetViewModel(
        titleText: "Delete Profile",
        detailText: "Are you sure you want to delete your profile? Doing so will erase all data and this action cannot be undone.",
        cancelButtonTittle: "Cancel",
        confirmButtonTittle: "Delete",
        isDestructive: true,
    );
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

