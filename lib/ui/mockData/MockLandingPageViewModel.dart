import 'package:farmsmart_flutter/ui/LandingPage.dart';
import 'package:intl/intl.dart';

class _LocalisedStrings {
  static String detailText() =>
      Intl.message('A network and knowledge source for farmers in Kenya');

  static String actionText() => Intl.message('Get Started');

  static String footerText() =>
      Intl.message('Switch language – Badilisha Lugha');
}

class MockLandingPageViewModel {
  static LandingPageViewModel build() {
    return LandingPageViewModel(
      detailText: _LocalisedStrings.detailText(),
      actionText: _LocalisedStrings.actionText(),
      footerText: _LocalisedStrings.footerText(),
      headerImage: "assets/raw/illustration_welcome.png",
      subtitleImage: "assets/raw/logo_default.png",
      switchLanguageTapped: (language, country) => _mockSwitchLanguage(language, country),
    );
  }

  static _mockSwitchLanguage(String language, String country) {
    print(language + " " + country);
  }
}
