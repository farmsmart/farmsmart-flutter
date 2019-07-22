import 'package:farmsmart_flutter/data/bloc/article/ArticleDetailTransformer.dart';
import 'package:farmsmart_flutter/data/bloc/article/ArticleListItemViewModelTransformer.dart';
import 'package:farmsmart_flutter/ui/common/ActionSheetListItem.dart';
import 'package:farmsmart_flutter/data/model/mock/MockArticle.dart';
import 'package:farmsmart_flutter/ui/common/CircularProgress.dart';
import 'package:farmsmart_flutter/ui/common/DogTagStyles.dart';
import 'package:farmsmart_flutter/ui/common/Dogtag.dart';
import 'package:farmsmart_flutter/ui/common/recommendation_card/recommendation_card.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:farmsmart_flutter/ui/common/stage_card.dart';
import 'package:farmsmart_flutter/ui/discover/HeroListItem.dart';
import 'package:farmsmart_flutter/ui/discover/StandardListItem.dart';
import 'package:farmsmart_flutter/ui/mockData/MockActionSheetViewModel.dart';
import 'package:farmsmart_flutter/ui/mockData/MockDogTagViewModel.dart';
import 'package:farmsmart_flutter/ui/mockData/MockRoundedButtonViewModel.dart';
import 'package:farmsmart_flutter/ui/mockData/MockStageCardViewModel.dart';
import 'package:farmsmart_flutter/ui/playground/data/playground_data_source.dart';
import 'package:farmsmart_flutter/ui/playground/data/playground_recommendation_card_datasource.dart';
import 'package:farmsmart_flutter/ui/playground/data/playground_recommendation_detail_card_datasource.dart';
import 'package:farmsmart_flutter/ui/playground/playground_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../playground_view.dart';

MockArticle _articleBuilder = MockArticle();

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
            style: RoundedButtonStyle.largeRoundedButtonStyle(),
          ),
        ),
      ),

      PlaygroundWidget(
        title: 'RoundedButton Compact',
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20.0),
          height: 64,
          child: RoundedButton(
            viewModel: MockRoundedButtonViewModel.buildCompact(),
            style: RoundedButtonStyle.defaultStyle(),
          ),
        ),
      ),

      PlaygroundWidget(
        title: 'RoundedButton Compact Big',
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20.0),
          height: 88,
          child: RoundedButton(
            viewModel: MockRoundedButtonViewModel.buildCompact(),
            style: RoundedButtonStyle.bigRoundedButton(),
          ),
        ),
      ),

      PlaygroundWidget(
        title: 'DogTag Days',
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20.0),
          height: 100,
          child: DogTag(
            viewModel: MockDogTagViewModel.buildWithText(),
            style: DogTagStyles.compactStyle(),
          ),
        ),
      ),

      PlaygroundWidget(
        title: 'DogTag Positive',
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20.0),
          height: 1000,
          child: DogTag(
            viewModel: MockDogTagViewModel.buildWithPositiveNumber(),
            style: DogTagStyles.positiveStyle(),
          ),
        ),
      ),

      PlaygroundWidget(
        title: 'DogTag Negative',
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20.0),
          height: 100,
          child: DogTag(
            viewModel: MockDogTagViewModel.buildWithNegativeNumber(),
            style: DogTagStyles.negativeStyle(),
          ),
        ),
      ),

      PlaygroundWidget(
        title: 'Simple Action Sheet Item',
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: ActionSheetListItem(
              viewModel:
                  MockActionSheetViewModel.buildStandard().actions.first),
        ),
      ),
      PlaygroundWidget(
        title: 'Action Sheet Item with Icon',
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: ActionSheetListItem(
              viewModel:
                  MockActionSheetViewModel.buildWithIcon().actions.first),
        ),
      ),
      PlaygroundWidget(
        title: 'Action Sheet Item with Checkbox',
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: ActionSheetListItem(
              viewModel:
                  MockActionSheetViewModel.buildWithCheckBox().actions.first),
        ),
      ),

      PlaygroundWidget(
        title: 'CircularProgress',
        child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: CircularProgress(
              progress: 0.75,
              lineWidth: 3,
              size: 87,
            )),
      ),
      PlaygroundWidget(
        title: 'Stage Card',
        child: Container(
          height: 162,
          child: StageCard(
            viewModel: MockStageCardViewModel.buildCompleteState(),
          ),
        ),
      ),
      StandardListItem(
              viewModel: ArticleListItemViewModelTransformer(
                      detailTransformer:
                          ArticleDetailViewModelTransformer(
                              listItemTransformer:
                                  ArticleListItemViewModelTransformer()))
                  .transform(from: _articleBuilder.build())),
          HeroListItem(
              viewModel: ArticleListItemViewModelTransformer(
                      detailTransformer:
                          ArticleDetailViewModelTransformer(
                              listItemTransformer:
                                  ArticleListItemViewModelTransformer()))
                  .transform(from: _articleBuilder.build())),
      RoundedButton(viewModel: MockRoundedButtonViewModel.buildLarge(), style: RoundedButtonStyle.largeRoundedButtonStyle()),
      RoundedButton(viewModel: MockRoundedButtonViewModel.buildCompact(), style: RoundedButtonStyle.defaultStyle()),
      RoundedButton(viewModel: MockRoundedButtonViewModel.buildCompact(), style: RoundedButtonStyle.bigRoundedButton()),
      ActionSheetListItem(viewModel: MockActionSheetViewModel.buildStandard().actions.first),
      ActionSheetListItem(viewModel: MockActionSheetViewModel.buildWithIcon().actions.first),
      ActionSheetListItem(viewModel: MockActionSheetViewModel.buildWithCheckBox().actions.first),
      PlaygroundWidget(
        title: 'Recommendation Card',
        child: PlaygroundView(
          widgetList: PlaygroundRecommendationCardDataSource().getList(),
        ),
      ),
      PlaygroundWidget(
        title: 'Recommendation detail card',
        child: PlaygroundView(
          widgetList: PlaygroundRecommendationDetailCardDatasource().getList(),
        ),
      )
    ];
  }
}
