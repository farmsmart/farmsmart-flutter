import 'package:farmsmart_flutter/ui/LandingPage.dart';
import 'package:farmsmart_flutter/ui/mockData/MockActionSheetViewModel.dart';
import 'package:intl/intl.dart';

class _Strings {
  static String detailText =
      "A network and knowledge source for farmers in Kenya";
  static String actionText = "Get Started";
  static String footerText = "Switch Langauge – Badilisha Lugha";
}

class MockLandingPageViewModel {
  static LandingPageViewModel build() {
    return LandingPageViewModel(
      detailText: Intl.message(_Strings.detailText),
      actionText: Intl.message(_Strings.actionText),
      footerText: Intl.message(_Strings.footerText),
      headerImage: "assets/raw/illustration_welcome.png",
      subtitleImage: "assets/raw/logo_default.png",
      continueAction: () => _mockAction(),
      actionSheetViewModel: MockActionSheetViewModel.buildWithCheckBox(),
      switchLanguageTapped: (language) => _mockSwitchLanguage(language),
    );
  }

  static void _mockAction() {
    return print("This should be a Navigator for chat route");
  }

  static _mockSwitchLanguage(String language) {
    print(language);
  }
}
