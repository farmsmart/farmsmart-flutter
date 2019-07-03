import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:farmsmart_flutter/ui/common/MockString.dart';


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
