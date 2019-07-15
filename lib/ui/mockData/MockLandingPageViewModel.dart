import 'package:farmsmart_flutter/ui/LandingPage.dart';

class MockLandingPageViewModel {
  static LandingPageViewModel build() {
    return LandingPageViewModel(
        detailText:
            "Kuwezesha wakenya elimu inayohitajika kuwa wakulima wenye mafanikio.",
        actionText: "Anza",
        footerText: "Badilisha Lugha – Switch Langauge",
        headerImage: "assets/raw/illustration_welcome.png",
        subtitleImage: "assets/raw/logo_default.png");
  }
}
