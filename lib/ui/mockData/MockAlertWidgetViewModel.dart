import 'package:farmsmart_flutter/ui/common/AlertWidget.dart';
import 'package:farmsmart_flutter/ui/common/MockString.dart';

class MockAlertWidgetViewModel {
  static AlertWidgetViewModel build() {
    return AlertWidgetViewModel(
      titleText: _mockTitle.random(),
      detailText: _mockDetail.random(),
      cancelButtonTittle: _mockButtonTitle.random(),
      confirmButtonTittle: _mockButtonTitle.random(),
    );
  }
}

MockString _mockTitle = MockString(library: [
  "Begin stge 2",
  "End stage 3 a bit larger",
  "Begin stage 56 a way more larger title"
]);

MockString _mockDetail = MockString(library: [
  "Some detail text",
  "Some a bit more large detail text",
  "A way more larger detail text on this field for testing pruproses"
]);

MockString _mockButtonTitle = MockString(library: [
  "Yes",
  "Cancel"
]);

