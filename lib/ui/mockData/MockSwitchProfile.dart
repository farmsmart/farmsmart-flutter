import 'package:farmsmart_flutter/ui/profile/SwitchProfile.dart';

class MockSwitchProfile {
  static SwitchProfileViewModel build() {
    return SwitchProfileViewModel(
      //TODO:Needs to return a list of SwitchProfilesItems when created VM and Style
        actions: [],
        title: "Switch Profile",
        actionTitle: "Switch Profile",
        isVisible: false);
  }
}
