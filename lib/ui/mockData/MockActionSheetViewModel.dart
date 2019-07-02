import 'dart:math';
import 'package:farmsmart_flutter/ui/common/ActionSheet.dart';
import 'package:farmsmart_flutter/ui/common/MockString.dart';


class MockActionSheetViewModel {
  static ActionSheetViewModel buildStandard() {
    List<ActionListItemViewModel> list = [];
    for(var i = 0; i < 2; i++) {
      list.add(ActionListItemViewModel(_mockItemTitleStandard[i], null, _mockItemDestructive[i+1]));
    }

    return ActionSheetViewModel(
        list,
        _mockButtonTitle.random(),
        cancelButtonTitle: _mockButtonTitle.random(),
    );
  }

  static ActionSheetViewModel buildStandardBigger() {
    List<ActionListItemViewModel> list = [];
    for(var i = 0; i < 3; i++) {
      list.add(ActionListItemViewModel(_mockItemTitleStandardBigger[i], null, _mockItemDestructive[i]));
    }

    return ActionSheetViewModel(
      list,
      _mockButtonTitle.random(),
      cancelButtonTitle: _mockButtonTitle.random(),
    );
  }

  static ActionSheetViewModel buildWithIcon() {
    List<ActionListItemViewModel> list = [];
    for(var i = 0; i < 2; i++) {
      list.add(ActionListItemViewModel(_mockItemTitleWithIcon[i], null, false, icon: _mockIcon[i]));
    }

    return ActionSheetViewModel(
      list,
      _mockButtonTitle.random(),
      cancelButtonTitle: _mockButtonTitle.random(),
    );
  }

  static ActionSheetViewModel buildWithCheckBox() {
    List<ActionListItemViewModel> list = [];
    for(var i = 0; i < 2; i++) {
      list.add(ActionListItemViewModel(_mockItemTitleSelectable[i], null, false, icon: _mockFlagIcon[i], checkBoxIcon: _mockCheckBoxIcon[i]));
    }

    return ActionSheetViewModel(
      list,
      _mockButtonTitle.random(),
      cancelButtonTitle: _mockButtonTitle.random(),
    );
  }
}

List _mockItemTitleStandard = ["Rename Crop", "Delete Crop"];
List _mockItemDestructive = [false, false, true];
List _mockItemTitleStandardBigger = ["Take New Photo", "Choose from LIbrary", "Remove Current Photo"];
List _mockItemTitleWithIcon = ["Record a New Sale", "Record a new Cost"];
List _mockItemTitleSelectable = ["English", "Swahili"];
List _mockIcon = ["assets/icons/detail_icon_cost.png", "assets/icons/detail_icon_sale.png"];
List _mockFlagIcon = ["assets/icons/flag_kenya.png", "assets/icons/flag_usa.png"];
List _mockCheckBoxIcon = ["assets/icons/radio_button_active.png", "assets/icons/radio_button_default.png"];

MockString _mockButtonTitle = MockString(library: [
  "Cancel"]);


