import 'package:farmsmart_flutter/ui/LandingPage.dart';
import 'package:intl/intl.dart';

class _Strings {
  static String detailText = ("A network and knowledge source for farmers in Kenya");
  static String actionText = ("Get Started");
  static String footerText = ("Switch Langauge – Badilisha Lugha");
}


class MockLandingPageViewModel {
  static LandingPageViewModel build() {
    return LandingPageViewModel(
        detailText: _Strings.detailText,
        actionText: _Strings.actionText,
        footerText: _Strings.footerText,
        headerImage: "assets/raw/illustration_welcome.png",
        subtitleImage: "assets/raw/logo_default.png");
  }
}
