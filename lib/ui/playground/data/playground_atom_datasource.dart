import 'package:farmsmart_flutter/ui/profitloss/RecordAmountDate.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordAmountHeader.dart';
import 'package:farmsmart_flutter/data/bloc/article/ArticleDetailTransformer.dart';
import 'package:farmsmart_flutter/data/bloc/article/ArticleListItemViewModelTransformer.dart';
import 'package:farmsmart_flutter/data/repositories/article/implementation/MockArticlesRepository.dart';
import 'package:farmsmart_flutter/ui/discover/HeroListItem.dart';
import 'package:farmsmart_flutter/ui/discover/StandardListItem.dart';
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
      RecordAmountPicker(
          viewModel: RecordAmountPickerViewModel(
              "assets/icons/detail_icon_date.png",
              "Date",
              "Today",
              "assets/icons/chevron.png",
              selectedDate: DateTime.now())),
      RecordAmountPicker(
          viewModel: RecordAmountPickerViewModel(
              "assets/icons/detail_icon_date.png",
              "Date",
              "Today",
              "assets/icons/chevron.png",
              listOfCrops: [
            "Okra",
            "Tomatoes",
            "Potatoes",
            "Cowpeas",
            "Sweetcorn",
            "Cucumber",
            "Beetroot"
          ])),
      StandardListItem(
          viewModel: ArticleListItemViewModelTransformer(
                  detailTransformer: ArticleDetailViewModelTransformer(
                      listItemTransformer:
                          ArticleListItemViewModelTransformer()))
              .transform(from: MockArticle.build())),
      HeroListItem(
          viewModel: ArticleListItemViewModelTransformer(
                  detailTransformer: ArticleDetailViewModelTransformer(
                      listItemTransformer:
                          ArticleListItemViewModelTransformer()))
              .transform(from: MockArticle.build())),
    ];
  }
}
