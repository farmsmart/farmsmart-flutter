import 'dart:math';

import 'package:farmsmart_flutter/model/bloc/StaticViewModelProvider.dart';
import 'package:farmsmart_flutter/model/repositories/image/implementation/MockImageEntity.dart';
import 'package:farmsmart_flutter/ui/mockData/MockSwitchProfile.dart';
import 'package:farmsmart_flutter/ui/profile/Profile.dart';
import 'package:farmsmart_flutter/ui/profile/ProfileListItem.dart';
import 'package:farmsmart_flutter/ui/profile/SwitchProfileList.dart';
import 'package:intl/intl.dart';
import 'package:farmsmart_flutter/model/entities/mock/MockString.dart';

class MockProfileViewModel {
  static ProfileViewModel build() {
    List<ProfileListItemViewModel> list = [];
    for (var i = 0; i < 8; i++) {
      list.add(MockUserProfileListItemViewModel.build(i));
    }

    return ProfileViewModel(
      username: _mockUserName.random(),
      activeCrops: Random().nextInt(50),
      completedCrops: Random().nextInt(50),
      image: MockImageEntity().build().urlProvider,
      switchProfileProvider: StaticViewModelProvider<SwitchProfileListViewModel>(MockSwitchProfile.build()),
    );
  }

  static ProfileViewModel buildLarger() {
    List<ProfileListItemViewModel> list = [];
    for (var i = 0; i < 8; i++) {
      list.add(MockUserProfileListItemViewModel.buildLarger(i));
    }

    return ProfileViewModel(
      username: _mockUserName.random(),
      activeCrops: Random().nextInt(150),
      completedCrops: Random().nextInt(150),
      image: MockImageEntity().build().urlProvider,
      switchProfileProvider: StaticViewModelProvider<SwitchProfileListViewModel>(MockSwitchProfile.build()),
    );
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

MockString _mockUserName = MockString(library: [
  "Ireti Kuta",
]);
