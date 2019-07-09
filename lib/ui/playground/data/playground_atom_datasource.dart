import 'package:farmsmart_flutter/ui/profitloss/RecordAmountDate.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordAmountHeader.dart';
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
      RoundedButton(
          viewModel: MockRoundedButtonViewModel.buildLarge(),
          style: RoundedButtonStyle.largeRoundedButtonStyle()),
      RoundedButton(
          viewModel: MockRoundedButtonViewModel.buildCompact(),
          style: RoundedButtonStyle.defaultStyle()),
      RoundedButton(
          viewModel: MockRoundedButtonViewModel.buildCompact(),
          style: RoundedButtonStyle.bigRoundedButton()),
      DogTag(
          viewModel: MockDogTagViewModel.buildWithText(),
          style: DogTagStyle.defaultStyle()),
      DogTag(
          viewModel: MockDogTagViewModel.buildWithPositiveNumber(),
          style: DogTagStyle.defaultStyle()),
      DogTag(
          viewModel: MockDogTagViewModel.buildWithNegativeNumber(),
          style: DogTagStyle.negativeStyle()),
      ActionSheetListItem(
          viewModel: MockActionSheetViewModel.buildStandard().actions.first),
      ActionSheetListItem(
          viewModel: MockActionSheetViewModel.buildWithIcon().actions.first),
      ActionSheetListItem(
          viewModel:
              MockActionSheetViewModel.buildWithCheckBox().actions.first),
      RecordAmountHeader(
          viewModel: RecordAmountHeaderViewModel("00"),
          style: RecordAmountHeaderStyle.defaultCostStyle()),
      RecordAmountHeader(
          viewModel: RecordAmountHeaderViewModel("00"),
          style: RecordAmountHeaderStyle.defaultSaleStyle()),
      RecordAmountDate(
          viewModel: RecordAmountDateViewModel(
              "assets/icons/detail_icon_date.png",
              "Date",
              "Today",
              "assets/icons/chevron.png",
              DateTime.now()))
    ];
  }
}
