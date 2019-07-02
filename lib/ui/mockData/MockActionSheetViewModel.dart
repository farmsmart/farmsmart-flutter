import 'dart:math';
import 'package:farmsmart_flutter/ui/common/ActionSheet.dart';
import 'package:farmsmart_flutter/ui/common/ActionSheetListItem.dart';
import 'package:farmsmart_flutter/ui/common/MockString.dart';


class MockActionSheetViewModel {
  static ActionSheetViewModel buildStandard() {
    List<ActionSheetListItemViewModel> list = [];
    for(var i = 0; i < 2; i++) {
      list.add(MockActionSheetListItemViewModel.buildStandard(i));
    }

    return ActionSheetViewModel(
        list,
        _mockButtonTitle.random(),
        cancelButtonTitle: _mockButtonTitle.random(),
    );
  }

  static ActionSheetViewModel buildStandardBigger() {
    List<ActionSheetListItemViewModel> list = [];
    for(var i = 0; i < 3; i++) {
      list.add(MockActionSheetListItemViewModel.buildStandardBigger(i));
    }

    return ActionSheetViewModel(
      list,
      _mockButtonTitle.random(),
      cancelButtonTitle: _mockButtonTitle.random(),
    );
  }

  static ActionSheetViewModel buildWithIcon() {
    List<ActionSheetListItemViewModel> list = [];
    for(var i = 0; i < 2; i++) {
      list.add(MockActionSheetListItemViewModel.buildWithIcon(i));
    }

    return ActionSheetViewModel(
      list,
      _mockButtonTitle.random(),
      cancelButtonTitle: _mockButtonTitle.random(),
    );
  }

  static ActionSheetViewModel buildWithCheckBox() {
    List<ActionSheetListItemViewModel> list = [];
    for(var i = 0; i < 2; i++) {
      list.add(MockActionSheetListItemViewModel.buildWithCheckbox(i));
    }

    return ActionSheetViewModel(
      list,
      _mockButtonTitle.random(),
      cancelButtonTitle: _mockButtonTitle.random(),
    );
  }
}

class MockActionSheetListItemViewModel {
  static ActionSheetListItemViewModel buildStandard(index) {
    return ActionSheetListItemViewModel(
      _mockItemTitleStandard[index],
      null,
      _mockItemDestructive[index],
    );
  }

  static ActionSheetListItemViewModel buildStandardBigger(index) {
    return ActionSheetListItemViewModel(
      _mockItemTitleStandardBigger[index],
      null,
      _mockItemDestructive[index],
    );
  }

  static ActionSheetListItemViewModel buildWithIcon(index) {
    return ActionSheetListItemViewModel(
      _mockItemTitleWithIcon[index],
      null,
      _mockItemDestructive[index],
      icon: _mockIcon[index]
    );
  }

  static ActionSheetListItemViewModel buildWithCheckbox(index) {
    return ActionSheetListItemViewModel(
        _mockItemTitleSelectable[index],
      null,
      _mockItemDestructive[index],
      icon: _mockFlagIcon[index],
      checkBoxIcon: _mockCheckBoxIcon[index]
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


