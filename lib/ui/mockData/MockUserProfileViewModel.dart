import 'dart:math';

import 'package:farmsmart_flutter/ui/profile/UserProfile.dart';
import 'package:farmsmart_flutter/ui/profile/UserProfileListItem.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:farmsmart_flutter/model/model/mock/MockString.dart';

class MockUserProfileViewModel {
  static UserProfileViewModel build() {
    List<UserProfileListItemViewModel> list = [];
    for (var i = 0; i < 8; i++) {
      list.add(MockUserProfileListItemViewModel.build(i));
    }

    return UserProfileViewModel(
      items: list,
      username: _mockUserName.random(),
      activeCrops: Random().nextInt(50),
      completedCrops: Random().nextInt(50),
      image: NetworkImage(_mockImage.random()),
      switchProfileAction: () => _mockSwitchTap(),
    );
  }

  static UserProfileViewModel buildLarger() {
    List<UserProfileListItemViewModel> list = [];
    for (var i = 0; i < 8; i++) {
      list.add(MockUserProfileListItemViewModel.buildLarger(i));
    }

    return UserProfileViewModel(
      items: list,
      username: _mockUserName.random(),
      activeCrops: Random().nextInt(150),
      completedCrops: Random().nextInt(150),
      image: NetworkImage(_mockImage.random()),
      switchProfileAction: () => _mockSwitchTap(),
    );
  }

  static _mockSwitchTap() {
    print("Profile switched");
  }
}

class MockUserProfileListItemViewModel {
  static UserProfileListItemViewModel build(index) {
    return UserProfileListItemViewModel(
      title: _mockActionTitle[index],
      icon: _mockActionIcon[index],
      onTap: () => _mockItemTap(),
      isDestructive: index != 7 ? false : true,
    );
  }

  static UserProfileListItemViewModel buildLarger(index) {
    return UserProfileListItemViewModel(
      title: _mockActionTitleLarger[index],
      icon: _mockActionIcon[index],
      onTap: () => _mockItemTap(),
      isDestructive: index != 7 ? false : true,
    );
  }

  static _mockItemTap() {
    print("Was tapped");
  }
}

class _LocalisedStrings {
  static String switchLanguage() => Intl.message("Switch Language");

  static String farmDetails() => Intl.message("Your Farm Details");

  static String updatePin() => Intl.message("Update Pin");

  static String createNewProfile() => Intl.message("Create New Profile");

  static String inviteFriends() => Intl.message("Invite Friends");

  static String privacyPolicy() => Intl.message("Privacy Policy");

  static String termsOfUse() => Intl.message("Terms of Use");

  static String deleteProfile() => Intl.message("Delete Profile");

  static String dummyTitle1() =>
      Intl.message("Lorem ipsum dolor sit amet, consectetur adipiscing elit.");

  static String dummyTitle2() => Intl.message(
      "Maecenas vitae risus vitae nulla euismod viverra ut eu lacus.");

  static String dummyTitle3() =>
      Intl.message("Duis at dolor posuere, iaculis diam a, dictum urna.");

  static String dummyTitle4() => Intl.message(
      "Mauris a turpis sem. Cras eleifend semper lorem id feugiat.");

  static String dummyTitle5() =>
      Intl.message("Lorem ipsum dolor sit amet, consectetur adipiscing elit.");

  static String dummyTitle6() =>
      Intl.message("Donec a magna a ipsum aliquet fringilla.");

  static String dummyTitle7() => Intl.message(
      "Mauris elementum arcu turpis, ac imperdiet sem rutrum vel.");

  static String dummyTitle8() => Intl.message(
      "Sed eu fermentum nisi. Fusce dui velit, dictum nec dictum eget, varius at felis.");
}

List<String> _mockActionTitleLarger = [
  _LocalisedStrings.dummyTitle1(),
  _LocalisedStrings.dummyTitle2(),
  _LocalisedStrings.dummyTitle3(),
  _LocalisedStrings.dummyTitle4(),
  _LocalisedStrings.dummyTitle5(),
  _LocalisedStrings.dummyTitle6(),
  _LocalisedStrings.dummyTitle7(),
  _LocalisedStrings.dummyTitle8(),
];

List<String> _mockActionTitle = [
  _LocalisedStrings.switchLanguage(),
  _LocalisedStrings.farmDetails(),
  _LocalisedStrings.updatePin(),
  _LocalisedStrings.createNewProfile(),
  _LocalisedStrings.inviteFriends(),
  _LocalisedStrings.privacyPolicy(),
  _LocalisedStrings.termsOfUse(),
  _LocalisedStrings.deleteProfile(),
];
List<String> _mockActionIcon = [
  "assets/icons/detail_icon_language.png",
  "assets/icons/detail_icon_best_soil.png",
  "assets/icons/detail_icon_pin.png",
  "assets/icons/detail_icon_new_profile.png",
  "assets/icons/detail_icon_invite.png",
  null,
  null,
  null,
];

MockString _mockImage = MockString(library: [
  "https://i.pinimg.com/originals/29/01/c9/2901c94b5a24c2f69d827e1755b5257e.jpg",
  "https://vignette.wikia.nocookie.net/rugratseries/images/1/1a/Tommy.jpg/revision/latest?cb=20110202050218",
  "https://www.flower-pepper.com/wp-content/uploads/2016/10/Kermit-the-Frog-by-Bartholomew-300x378.jpg",
]);

MockString _mockUserName = MockString(library: [
  "Ireti Kuta",
]);
