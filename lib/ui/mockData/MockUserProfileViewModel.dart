import 'dart:math';

import 'package:farmsmart_flutter/ui/profile/UserProfile.dart';
import 'package:farmsmart_flutter/ui/profile/UserProfileListItem.dart';
import 'package:farmsmart_flutter/ui/profitloss/mockRepositoryTryout/MockString.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


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

  static _mockSwitchTap() {
    print("Profile switched");
  }
}

class MockUserProfileListItemViewModel {
  static UserProfileListItemViewModel build(index) {
    return UserProfileListItemViewModel(
      title: Intl.message(_mockActionTitle[index]),
      icon: _mockActionIcon[index],
      onTap: () => _mockItemTap(),
      isDestructive: index != 7 ? false : true,
    );
  }

  static _mockItemTap() {
    print("Was tapped");
  }
}


List<String> _mockActionTitle = [
  "Switch Language",
  "Your Farm Details",
  "Update Pin",
  "Create New Profile",
  "Invite Friends",
  "Privacy Policy",
  "Terms of Use",
  "Delete Profile",
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
  "https://qph.fs.quoracdn.net/main-qimg-41f4a796c09d0c605df5d6fedf4ad980"
  "https://i.pinimg.com/originals/29/01/c9/2901c94b5a24c2f69d827e1755b5257e.jpg",
  "https://occ-0-1722-1723.1.nflxso.net/art/d2938/a54bf5710e24e03aed993f1597454a46699d2938.jpg",
  "https://www.flower-pepper.com/wp-content/uploads/2016/10/Kermit-the-Frog-by-Bartholomew-300x378.jpg",
  "https://vignette.wikia.nocookie.net/rugratseries/images/1/1a/Tommy.jpg/revision/latest?cb=20110202050218",
]);

MockString _mockUserName = MockString(library: [
  "Name",
  "Mininame",
  "Ireti Kuta",
  "Longer User Name",
]);
