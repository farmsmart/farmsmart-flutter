
import 'package:farmsmart_flutter/ui/common/ActionSheet.dart';
import 'package:farmsmart_flutter/ui/mockData/MockActionSheetViewModel.dart';
import 'package:flutter/material.dart';

class PlaygroundWidgetList {

  static List<Widget> completeListOfWidgets = [
    ActionSheet(viewModel: MockActionSheetViewModel.buildStandard(), style: ActionSheetStyle.defaultStyle()),
    ActionSheet(viewModel: MockActionSheetViewModel.buildStandardBigger(), style: ActionSheetStyle.defaultStyle()),
    ActionSheet(viewModel: MockActionSheetViewModel.buildWithIcon(), style: ActionSheetStyle.defaultStyle()),
    ActionSheet(viewModel: MockActionSheetViewModel.buildWithCheckBox(), style: ActionSheetStyle.selectableStyle())

  ];
}