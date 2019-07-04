import 'package:farmsmart_flutter/ui/common/Dogtag.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:farmsmart_flutter/ui/mockData/MockDogTagViewModel.dart';
import 'package:farmsmart_flutter/ui/mockData/MockRoundedButtonViewModel.dart';
import 'package:farmsmart_flutter/ui/common/ActionSheetListItem.dart';
import 'package:farmsmart_flutter/ui/mockData/MockActionSheetViewModel.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/ui/playground/data/playground_data_source.dart';

class PlayGroundAtomDataSource implements PlaygroundDataSource {
  @override
  List<Widget> getList() {
    return [
      //Add your atoms here
      RoundedButton(viewModel: MockRoundedButtonViewModel.buildLarge(), style: RoundedButtonStyle.largeRoundedButtonStyle()),
      RoundedButton(viewModel: MockRoundedButtonViewModel.buildCompact(), style: RoundedButtonStyle.defaultStyle()),
      RoundedButton(viewModel: MockRoundedButtonViewModel.buildCompact(), style: RoundedButtonStyle.bigRoundedButton()),
      DogTag(viewModel: MockDogTagViewModel.buildWithText(), style: DogTagStyle.defaultStyle()),
      DogTag(viewModel: MockDogTagViewModel.buildWithPositiveNumber(), style: DogTagStyle.defaultStyle()),
      DogTag(viewModel: MockDogTagViewModel.buildWithNegativeNumber(), style: DogTagStyle.negativeStyle()),
      Text('Atom widget 1'),
      Card(child: Text('Atom widget 2')),
      Text('Atom widget 4'),
      ActionSheetListItem(style: ActionSheetListItemStyle.defaultStyle(), viewModel: MockActionSheetViewModel.buildStandard().actions.first, numberOfActions: 1, currentAction: 1),
      ActionSheetListItem(style: ActionSheetListItemStyle.defaultStyle(), viewModel: MockActionSheetViewModel.buildWithIcon().actions.first, numberOfActions: 1, currentAction: 1),
      ActionSheetListItem(style: ActionSheetListItemStyle.selectableStyle(), viewModel: MockActionSheetViewModel.buildWithCheckBox().actions.first, numberOfActions: 1, currentAction: 1)
      ActionSheetListItem(
          style: ActionSheetListItemStyle.defaultStyle(),
          viewModel: MockActionSheetViewModel.buildStandard().actions.first),
      ActionSheetListItem(
          style: ActionSheetListItemStyle.defaultStyle(),
          viewModel: MockActionSheetViewModel.buildWithIcon().actions.first),
      ActionSheetListItem(
          style: ActionSheetListItemStyle.selectableStyle(),
          viewModel: MockActionSheetViewModel.buildWithCheckBox().actions.first)
    ];
  }
}
