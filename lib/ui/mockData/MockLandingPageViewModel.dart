import 'package:farmsmart_flutter/ui/LandingPage.dart';
import 'package:farmsmart_flutter/ui/mockData/MockActionSheetViewModel.dart';
import 'package:intl/intl.dart';

class _LocalisedStrings {
  static String detailText() =>
      Intl.message('A network and knowledge source for farmers in Kenya');

  static String actionText() => Intl.message('Get Started');

  static String footerText() =>
      Intl.message('Switch Langauge – Badilisha Lugha');
}

class MockLandingPageViewModel {
  static LandingPageViewModel build() {
    return LandingPageViewModel(
      detailText: _LocalisedStrings.detailText(),
      actionText: _LocalisedStrings.actionText(),
      footerText: _LocalisedStrings.footerText(),
      headerImage: "assets/raw/illustration_welcome.png",
      subtitleImage: "assets/raw/logo_default.png",
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
