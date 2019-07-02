
import 'package:farmsmart_flutter/ui/common/ActionSheet.dart';
import 'package:farmsmart_flutter/ui/common/ActionSheetListItem.dart';
import 'package:farmsmart_flutter/ui/mockData/MockActionSheetViewModel.dart';
import 'package:flutter/material.dart';

class PlaygroundWidgetList {

  static List<Widget> completeListOfWidgets = [
    ActionSheetListItem(style: ActionSheetListItemStyle.defaultStyle(), viewModel: MockActionSheetViewModel.buildStandard().actions.first, numberOfActions: 1, currentAction: 1),
    ActionSheetListItem(style: ActionSheetListItemStyle.defaultStyle(), viewModel: MockActionSheetViewModel.buildWithIcon().actions.first, numberOfActions: 1, currentAction: 1),
    ActionSheetListItem(style: ActionSheetListItemStyle.selectableStyle(), viewModel: MockActionSheetViewModel.buildWithCheckBox().actions.first, numberOfActions: 1, currentAction: 1),
    ActionSheet(viewModel: MockActionSheetViewModel.buildStandard(), style: ActionSheetStyle.defaultStyle()),
    ActionSheet(viewModel: MockActionSheetViewModel.buildStandardBigger(), style: ActionSheetStyle.defaultStyle()),
    ActionSheet(viewModel: MockActionSheetViewModel.buildWithIcon(), style: ActionSheetStyle.defaultStyle()),
    ActionSheet(viewModel: MockActionSheetViewModel.buildWithCheckBox(), style: ActionSheetStyle.defaultStyle(), cellStyle: ActionSheetListItemStyle.selectableStyle())
  ];
}