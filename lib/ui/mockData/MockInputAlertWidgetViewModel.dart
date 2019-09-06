import 'package:farmsmart_flutter/model/entities/mock/MockString.dart';
import 'package:farmsmart_flutter/ui/common/InputAlert.dart';

class MockInputAlertViewModel {
  static InputAlertViewModel build() {
    return InputAlertViewModel(
      titleText: _mockTitle.random(),
      hint: _mockHint.random(),
      cancelActionText: "Cancel",
      confirmActionText: "Confirm",
      confirmInputAction: (value) => _mockAction(value),
    );
  }

  static _mockAction(String value) {
    print("Should be the correct action with $value");
  }
}

MockString _mockTitle = MockString(library: [
  "Rename crop",
]);

MockString _mockHint = MockString(library: [
  "Crop name",
]);
