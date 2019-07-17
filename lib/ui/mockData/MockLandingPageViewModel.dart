import 'package:farmsmart_flutter/ui/LandingPage.dart';
import 'package:intl/intl.dart';

class _Strings {
  static final String detailText = Intl.message("Kuwezesha wakenya elimu inayohitajika kuwa wakulima wenye mafanikio.");
  static final String actionText = Intl.message("Get Started");
  static final String footerText = Intl.message("Switch Langauge – Badilisha Lugha");
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
