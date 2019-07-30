import 'package:farmsmart_flutter/ui/profile/FarmDetails.dart';
import 'package:farmsmart_flutter/ui/profile/FarmDetailsListItem.dart';
import 'package:flutter/material.dart';

class MockFarmDetailsViewModel {
  static FarmDetailsViewModel build() {
    List<FarmDetailsListItemViewModel> list = [];

    for (var i = 0; i < 7; i++) {
      list.add(MockFarmDetailsListItemViewModel.build(i));
    }

    return FarmDetailsViewModel(
      items: list,
      buttonTitle: "Confirm Details",
      removeProfile: () => _mockRemoveProfile(),
      editProfile: () => _mockEditProfile(),
    );
  }

  static _mockRemoveProfile() {
    print("Remove Profile");
  }

  static _mockEditProfile() {
    print("Edit Profile");
  }
}

class MockFarmDetailsListItemViewModel {
  static FarmDetailsListItemViewModel build(index) {
    return FarmDetailsListItemViewModel(
      title: _mockTitle[index],
      detail: _mockDetail[index],
      colors: index == 5 ? _mockLargeListOfColors : null,
    );
  }
}

List _mockTitle = [
  "Your Name",
  "Country",
  "Land Size",
  "Season",
  "Motivation",
  "Soil Type",
  "Irrigation"
];
List _mockDetail = [
  "Ireti Kuta",
  "Meru",
  "Urban garden",
  "Short rains",
  "Myself",
  "Sandy, daslkd, asdlakj, asdasdlk",
  "Yes"
];

List<Color> _mockLargeListOfColors = [
  Color(0xffeac153),
  Color(0xffb3762e),
  Color(0xfff28282),
];
