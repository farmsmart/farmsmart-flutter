import 'package:farmsmart_flutter/model/model/mock/MockString.dart';
import 'package:farmsmart_flutter/ui/profile/SwitchProfileList.dart';
import 'package:farmsmart_flutter/ui/profile/SwitchProfileListItem.dart';
import 'package:flutter/material.dart';

class MockSwitchProfile {
  static SwitchProfileListViewModel build() {
    List<SwitchProfileListItemViewModel> list = [];
    for (var i = 0; i < 10; i++) {
      list.add(MockSwitchProfileItemsViewModel.build(i));
    }

    return SwitchProfileListViewModel(
      items: list,
      title: "Switch Profile",
      actionTitle: "Switch Profile",
      isVisible: false,
      selectedIndex: 0,
      confirmedIndex: 0,
      addProfileAction: () => _mockAddProfile(),
    );
  }

  static _mockAddProfile() {
    print("This should be a add Profile Screen");
  }
}

class MockSwitchProfileItemsViewModel {
  static SwitchProfileListItemViewModel build(index) {
    return SwitchProfileListItemViewModel(
      title: _mockTitle.random(),
      icon: "assets/icons/radio_button_default.png",
      image: NetworkImage(_mockImage.random()),
      isSelected: index == 0 ? true : false,
    );
  }
}

MockString _mockImage = MockString(library: [
  "https://media.licdn.com/dms/image/C4E0BAQEGKInje62bpg/company-logo_200_200/0?e=2159024400&v=beta&t=A2kD-9n-JWDfBqUwPdz7UQ581seMvVp2-m0o-eiGg_Y",
  "https://statictest.amido.com/wp-content/uploads/2016/02/02100213/Amido-1.png",
  "http://4.bp.blogspot.com/-2v3fdX2Y_-g/T04JTMAyX5I/AAAAAAAAAW4/AcYdf9Xwxho/s1600/GUSTAVO.jpg",
]);

MockString _mockTitle = MockString(library: [
  "Isioma Adegoke",
  "Ndubuisi Ajayi",
  "Temitope Aliero",
  "Safinatu Adegoke",
  "Ireti Kuta",
]);
