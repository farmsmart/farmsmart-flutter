import 'package:farmsmart_flutter/model/entities/mock/MockString.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';


class MockRoundedButtonViewModel {
  static RoundedButtonViewModel buildLarge() {
    return RoundedButtonViewModel(
      title: _mockTitleText.random(),
    );
  }

  static RoundedButtonViewModel buildCompact() {
    return RoundedButtonViewModel(
      icon: "assets/icons/profit_add.png"
    );
  }
}

MockString _mockTitleText = MockString(library: [
  "Add another crop",
  "short title",
  "short",
  "One more bigger title"
]);
