import 'package:farmsmart_flutter/model/entities/mock/MockString.dart';
import 'package:farmsmart_flutter/ui/common/ActionSheet.dart';
import 'package:farmsmart_flutter/ui/common/ActionSheetListItem.dart';

class MockActionSheetViewModel {
  static ActionSheetViewModel buildStandard() {
    List<ActionSheetListItemViewModel> list = [];
    for(var i = 0; i < 2; i++) {
      list.add(MockActionSheetListItemViewModel.buildStandard(i));
    }

    return ActionSheetViewModel(
        list,
        "Cancel",
    );
  }

  static ActionSheetViewModel buildStandardBigger() {
    List<ActionSheetListItemViewModel> list = [];
    for(var i = 0; i < 3; i++) {
      list.add(MockActionSheetListItemViewModel.buildStandardBigger(i));
    }

    return ActionSheetViewModel(
      list,
      "Cancel",
    );
  }

  static ActionSheetViewModel buildWithIcon() {
    List<ActionSheetListItemViewModel> list = [];
    for(var i = 0; i < 2; i++) {
      list.add(MockActionSheetListItemViewModel.buildWithIcon(i));
    }

    return ActionSheetViewModel(
      list,
      "Cancel",
    );
  }

  static ActionSheetViewModel buildWithCheckBox() {
    List<ActionSheetListItemViewModel> list = [];
    for(var i = 0; i < 2; i++) {
      list.add(MockActionSheetListItemViewModel.buildWithCheckbox(i));
    }

    return ActionSheetViewModel(
      list,
      "Cancel",
      confirmButtonTitle: _mockButtonTitle.random(),
    );
  }
}

class MockActionSheetListItemViewModel {
  static ActionSheetListItemViewModel buildStandard(index) {
    return ActionSheetListItemViewModel(
      title: _mockItemTitleStandard[index],
      type: ActionType.simple,
      onTap: () => actionTest("Tapped " + _mockItemTitleStandard[index]),
      isDestructive: _mockItemDestructive[index],
    );
  }

  static ActionSheetListItemViewModel buildStandardBigger(index) {
    return ActionSheetListItemViewModel(
      title: _mockItemTitleStandardBigger[index],
      type: ActionType.simple,
      onTap:  () => actionTest("Tapped " + _mockItemTitleStandardBigger[index]),
      isDestructive: _mockItemDestructive[index],
    );
  }

  static ActionSheetListItemViewModel buildWithIcon(index) {
    return ActionSheetListItemViewModel(
      title: _mockItemTitleWithIcon[index],
      type: ActionType.withIcon,
      onTap: () => actionTest("Tapped " + _mockItemTitleWithIcon[index]),
      isDestructive: _mockItemDestructive[index],
      icon: _mockIcon[index]
    );
  }

  static ActionSheetListItemViewModel buildWithCheckbox(index) {
    return ActionSheetListItemViewModel(
      title: _mockItemTitleSelectable[index],
      type: ActionType.selectable,
      onTap: () => actionTest("Tapped " + _mockItemTitleSelectable[index]),
      isDestructive: _mockItemDestructive[index],
      icon: _mockFlagIcon[index],
      checkBoxIcon: _mockCheckBoxIcon[index],
    );
  }

  static actionTest(String message) {
    print(message);
  }
}

List _mockItemTitleStandard = ["Rename Crop", "Delete Crop"];
List _mockItemDestructive = [false, false, true];
List _mockItemTitleStandardBigger = ["Take New Photo", "Choose from LIbrary", "Remove Current Photo"];
List _mockItemTitleWithIcon = ["Record a New Sale", "Record a new Cost"];
List _mockItemTitleSelectable = ["English", "Swahili"];
List _mockIcon = ["assets/icons/detail_icon_cost.png", "assets/icons/detail_icon_sale.png"];
List _mockFlagIcon = ["assets/icons/flag_usa.png", "assets/icons/flag_kenya.png"];
List _mockCheckBoxIcon = ["assets/icons/radio_button_active.png", "assets/icons/radio_button_default.png"];

MockString _mockButtonTitle = MockString(library: [
  "Confirm"]);


