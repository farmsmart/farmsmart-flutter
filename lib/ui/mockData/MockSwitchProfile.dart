import 'package:farmsmart_flutter/model/entities/mock/MockString.dart';
import 'package:farmsmart_flutter/model/repositories/image/implementation/MockImageEntity.dart';
import 'package:farmsmart_flutter/ui/profile/SwitchProfileList.dart';
import 'package:farmsmart_flutter/ui/profile/SwitchProfileListItem.dart';

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
      newProfileFlow: null,
    );
  }
}

class MockSwitchProfileItemsViewModel {
  static SwitchProfileListItemViewModel build(index) {
    return SwitchProfileListItemViewModel(
      title: _mockTitle.random(),
      icon: "assets/icons/radio_button_default.png",
      image: MockImageEntity().build().urlProvider,
      isSelected: index == 0 ? true : false,
    );
  }
}

MockString _mockTitle = MockString(library: [
  "Isioma Adegoke",
  "Ndubuisi Ajayi",
  "Temitope Aliero",
  "Safinatu Adegoke",
  "Ireti Kuta",
]);
