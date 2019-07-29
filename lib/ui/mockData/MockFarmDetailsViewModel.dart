import 'package:farmsmart_flutter/ui/profile/FarmDetails.dart';
import 'package:farmsmart_flutter/ui/profile/FarmDetailsListItem.dart';

class MockFarmDetailsViewModel {
  static FarmDetailsViewModel build() {
      List<FarmDetailsListItemViewModel> list = [];

      for (var i = 0; i < 7; i++) {
        list.add(MockFarmDetailsListItemViewModel.build(i));
      }

      return FarmDetailsViewModel(items: list, removeProfile: () => _mockRemoveProfile(), editProfile: () => _mockEditProfile());
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
    return FarmDetailsListItemViewModel (
      title: _mockTitle[index],
      detail: _mockDetail[index],
    );
  }
}


List _mockTitle = ["Your Name", "Country", "Land Size", "Season", "Motivation", "Soil Type", "Irrigation"];
List _mockDetail = ["Ireti Kuta", "Meru", "Urban garden", "Short rains", "Myself", "Sandy", "Yes"];