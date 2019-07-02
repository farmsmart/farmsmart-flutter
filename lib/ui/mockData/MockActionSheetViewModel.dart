import 'dart:math';
import 'package:farmsmart_flutter/ui/common/ActionSheet.dart';
import 'package:farmsmart_flutter/ui/common/MockString.dart';


class MockActionSheetViewModel {
  static ActionSheetViewModel build() {
    List<ActionListItemViewModel> list = [];
    for(var i = 0; i < 3; i++) {
      list.add(MockActionListItemViewModel.build());
    }

    return ActionSheetViewModel(
        list,
        _mockTitleText.random(),
        cancelButtonTitle: _mockTitleText.random(),
    );
  }
}

class MockActionListItemViewModel {
  static var randomBoolean = Random();

  static ActionListItemViewModel build() {
    return ActionListItemViewModel(
        _mockTitleText.random(),
       null,
       randomBoolean.nextBool(),
       icon: _mockIcon.random(),
       checkBoxIcon: _mockIcon.random(),
    );
  }
}


MockString _mockTitleText = MockString(library: [
  "Title example",
  "Longer title example",
  "This is a middle lenght title",
  "A Bit longer title example more longer example"]);

MockString _mockIcon = MockString(library: ["assets/icons/detail_icon_cost.png", "assets/icons/flag_kenya.png", "assets/icons/radio_button_active.png", "assets/icons/flag_usa.png", "assets/icons/detail_icon_sale.png"]);

