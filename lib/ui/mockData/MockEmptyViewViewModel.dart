import 'package:farmsmart_flutter/model/entities/mock/MockString.dart';
import 'package:farmsmart_flutter/ui/common/empty_view.dart';

class MockEmptyViewViewModel {
  static EmptyViewViewModel build() {
    return EmptyViewViewModel(
      imagePath: 'assets/raw/illustration_empty.png',
      description: _mockString.random(),
      actionText: 'Add to your Plot',
      action: () => {},
    );
  }
}

MockString _mockString = MockString(library: [
  "Get started by adding to your Plot",
  "Very large description to test if the widget is showing correctly.",
]);


