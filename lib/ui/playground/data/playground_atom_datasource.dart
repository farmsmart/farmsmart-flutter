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
import 'package:farmsmart_flutter/ui/playground/playground_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/ui/playground/data/playground_data_source.dart';

class PlayGroundAtomDataSource implements PlaygroundDataSource {
  @override
  List<Widget> getList() {
    return [
      //Add your atoms
      PlaygroundWidget(
          title: 'RoundedButton Large',
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20.0),
            height: 96,
            child: RoundedButton(
                viewModel: MockRoundedButtonViewModel.buildLarge(),
                style: RoundedButtonStyle.largeRoundedButtonStyle()),
          )),

      PlaygroundWidget(
          title: 'RoundedButton Compact',
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20.0),
            height: 64,
            child: RoundedButton(
                viewModel: MockRoundedButtonViewModel.buildCompact(),
                style: RoundedButtonStyle.defaultStyle()),
          )),

      PlaygroundWidget(
          title: 'RoundedButton Compact Big',
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20.0),
            height: 88,
            child: RoundedButton(
                viewModel: MockRoundedButtonViewModel.buildCompact(),
                style: RoundedButtonStyle.bigRoundedButton()),
          )),

      PlaygroundWidget(
          title: 'DogTag Days',
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20.0),
            height: 100,
            child: DogTag(
                viewModel: MockDogTagViewModel.buildWithText(),
                style: DogTagStyle.defaultStyle()),
          )),

      PlaygroundWidget(
          title: 'DogTag Positive',
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20.0),
            height: 1000,
            child: DogTag(
                viewModel: MockDogTagViewModel.buildWithPositiveNumber(),
                style: DogTagStyle.defaultStyle()),
          )),

      PlaygroundWidget(
          title: 'DogTag Negative',
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20.0),
            height: 100,
            child: DogTag(
                viewModel: MockDogTagViewModel.buildWithNegativeNumber(),
                style: DogTagStyle.negativeStyle()),
          )),

      PlaygroundWidget(
          title: 'Simple Action Sheet Item',
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: ActionSheetListItem(
                viewModel:
                    MockActionSheetViewModel.buildStandard().actions.first),
          )),
      PlaygroundWidget(
          title: 'Action Sheet Item with Icon',
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: ActionSheetListItem(
                viewModel:
                    MockActionSheetViewModel.buildWithIcon().actions.first),
          )),
      PlaygroundWidget(
          title: 'Action Sheet Item with Checkbox',
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: ActionSheetListItem(
                viewModel:
                    MockActionSheetViewModel.buildWithCheckBox().actions.first),
          )),
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
