import 'dart:math';

import 'package:farmsmart_flutter/model/bloc/StaticViewModelProvider.dart';
import 'package:farmsmart_flutter/ui/mockData/MockSwitchProfile.dart';
import 'package:farmsmart_flutter/ui/profile/Profile.dart';
import 'package:farmsmart_flutter/ui/profile/ProfileListItem.dart';
import 'package:farmsmart_flutter/ui/profile/SwitchProfileList.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:farmsmart_flutter/model/model/mock/MockString.dart';

class MockProfileViewModel {
  static ProfileViewModel build() {
    List<ProfileListItemViewModel> list = [];
    for (var i = 0; i < 8; i++) {
      list.add(MockUserProfileListItemViewModel.build(i));
    }

    return ProfileViewModel(
      items: list,
      username: _mockUserName.random(),
      activeCrops: Random().nextInt(50),
      completedCrops: Random().nextInt(50),
      image: NetworkImage(_mockImage.random()),
      switchProfileProvider: StaticViewModelProvider<SwitchProfileListViewModel>(MockSwitchProfile.build()),
    );
  }

  static ProfileViewModel buildLarger() {
    List<ProfileListItemViewModel> list = [];
    for (var i = 0; i < 8; i++) {
      list.add(MockUserProfileListItemViewModel.buildLarger(i));
    }

    return ProfileViewModel(
      items: list,
      username: _mockUserName.random(),
      activeCrops: Random().nextInt(150),
      completedCrops: Random().nextInt(150),
      image: NetworkImage(_mockImage.random()),
      switchProfileProvider: StaticViewModelProvider<SwitchProfileListViewModel>(MockSwitchProfile.build()),
    );
  }

  static _mockSwitchTap() {
    print("Profile switched");
  }
}

class MockUserProfileListItemViewModel {
  static ProfileListItemViewModel build(index) {
    return ProfileListItemViewModel(
      title: Intl.message(_mockActionTitle[index]),
      icon: _mockActionIcon[index],
      onTap: () => _mockItemTap(),
      isDestructive: index != 7 ? false : true,
    );
  }

  static ProfileListItemViewModel buildLarger(index) {
    return ProfileListItemViewModel(
      title: Intl.message(_mockActionTitleLarger[index]),
      icon: _mockActionIcon[index],
      onTap: () => _mockItemTap(),
      isDestructive: index != 7 ? false : true,
    );
  }

  static _mockItemTap() {
    print("Was tapped");
  }
}


List<String> _mockActionTitleLarger = [
  "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
  "Maecenas vitae risus vitae nulla euismod viverra ut eu lacus.",
  "Duis at dolor posuere, iaculis diam a, dictum urna.",
  "Mauris a turpis sem. Cras eleifend semper lorem id feugiat.",
  "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
  "Donec a magna a ipsum aliquet fringilla.",
  "Mauris elementum arcu turpis, ac imperdiet sem rutrum vel.",
  "Sed eu fermentum nisi. Fusce dui velit, dictum nec dictum eget, varius at felis.",
];

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
  "https://i.pinimg.com/originals/29/01/c9/2901c94b5a24c2f69d827e1755b5257e.jpg",
  "https://vignette.wikia.nocookie.net/rugratseries/images/1/1a/Tommy.jpg/revision/latest?cb=20110202050218",
  "https://www.flower-pepper.com/wp-content/uploads/2016/10/Kermit-the-Frog-by-Bartholomew-300x378.jpg",
]);

MockString _mockUserName = MockString(library: [
  "Ireti Kuta",
]);
