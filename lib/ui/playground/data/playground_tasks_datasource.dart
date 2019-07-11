import 'package:farmsmart_flutter/data/bloc/article/ArticleListProvider.dart';
import 'package:farmsmart_flutter/data/repositories/article/implementation/MockArticlesRepository.dart';
import 'package:farmsmart_flutter/ui/discover/ArticleList.dart';
import 'package:farmsmart_flutter/ui/common/ActionSheet.dart';
import 'package:farmsmart_flutter/ui/mockData/MockActionSheetViewModel.dart';
import 'package:farmsmart_flutter/ui/common/carousel_view.dart';
import 'package:farmsmart_flutter/ui/common/stage_card.dart';
import 'package:farmsmart_flutter/ui/mockData/MockStageCardViewModel.dart';
import 'package:farmsmart_flutter/ui/playground/data/playground_data_source.dart';
import 'package:farmsmart_flutter/ui/playground/playground_widget.dart';
import 'package:farmsmart_flutter/ui/playground/styles/stage_card_styles.dart';
import 'package:farmsmart_flutter/ui/profitloss/ProfitLossHeader.dart';
import 'package:farmsmart_flutter/ui/profitloss/ProfitLossListItem.dart';
import 'package:farmsmart_flutter/ui/profitloss/mockRepositoryTryout/MockTransactionRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../playground_view.dart';

class PlayGroundTasksDataSource implements PlaygroundDataSource {
  @override
  List<PlaygroundWidget> getList() {
    return [
      //Add Your tasks here
      PlaygroundWidget(
          title: 'TASK FARM-62 View-Prof-Loss-Statement',
          child: PlaygroundView(
            widgetList: [
              PlaygroundWidget(
                  title: 'TASK FARM-62 Profit-Loss Header',
                  child: ProfitLossHeader(
                      viewModel: MockProfitLossHeaderViewModel.build(),
                      style: ProfitLossHeaderStyle.defaultStyle())),
              PlaygroundWidget(
                title: 'TASK FARM-62 Profit-Loss Item Negative',
                child: ProfitLossListItem(
                    viewModel: MockProfitLossListItemViewModel.buildNegative(),
                    style: ProfitLossItemStyle.defaultStyle()),
              ),
              PlaygroundWidget(
                title: 'TASK FARM-62 Profit-Loss Item Positive',
                child: ProfitLossListItem(
                    viewModel: MockProfitLossListItemViewModel.buildPositive(),
                    style: ProfitLossItemStyle.defaultStyle()),
              ),
            ],
          )),
      PlaygroundWidget(
          title: 'FARM-355 Generic Action Sheet',
          child: PlaygroundView(
            widgetList: [
              PlaygroundWidget(
                  title: 'FARM-355 Generic Action Sheet - Simple',
                  child: Container(
                    height: 350,
                    child: ActionSheet(
                        viewModel: MockActionSheetViewModel.buildStandard(),
                        style: ActionSheetStyle.defaultStyle()),
                  )),
              PlaygroundWidget(
                  title: 'FARM-355 Generic Action Sheet - Larger',
                  child: Container(
                    height: 420,
                    child: ActionSheet(
                        viewModel:
                            MockActionSheetViewModel.buildStandardBigger(),
                        style: ActionSheetStyle.defaultStyle()),
                  )),
              PlaygroundWidget(
                  title: 'FARM-355 Generic Action Sheet - With icons',
                  child: Container(
                    height: 350,
                    child: ActionSheet(
                        viewModel: MockActionSheetViewModel.buildWithIcon(),
                        style: ActionSheetStyle.defaultStyle()),
                  )),
              PlaygroundWidget(
                  title: 'FARM-355 Generic Action Sheet - With checkBox',
                  child: Container(
                      height: 350,
                      child: ActionSheet(
                          viewModel:
                              MockActionSheetViewModel.buildWithCheckBox(),
                          style: ActionSheetStyle.defaultStyle()))),
            ],
          )),
      PlaygroundWidget(
          title: 'FARM-355 Generic Action Sheet - Type 4',
          child: Container(
              height: 350,
              child: ActionSheet(
                  viewModel: MockActionSheetViewModel.buildWithCheckBox(),
                  style: ActionSheetStyle.defaultStyle()))),
      PlaygroundWidget(
        title: 'TASK FARM-278 State carousel view',
        child: Container(
          height: 162,
          child: CarouselView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: StageCard(
                  viewModel: MockStageCardViewModel.buildCompleteState(),
                  style: StageCardStyles.getCompleteStageStyle(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: StageCard(
                  viewModel: MockStageCardViewModel.buildInProgressState(),
                  style: StageCardStyles.getInProgressStageStyle(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: StageCard(
                  viewModel: MockStageCardViewModel.buildUpcomingState(),
                  style: StageCardStyles.getUpcomingStageStyle(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: StageCard(
                  viewModel: MockStageCardViewModel.buildRandom(),
                  style: StageCardStyles.getUpcomingStageStyle(),
                ),
              ),
            ],
          ),
        ),
      ),
      PlaygroundWidget(
        title: 'TASK FARM-278 Card view',
        child: Container(
          height: 162,
          child: StageCard(
            viewModel: MockStageCardViewModel.buildCompleteState(),
          ),
        ),
      ),
      /* Template
      PlaygroundWidget(
        title: '#TASK NAME#',
        child: YourWidget(),
      ),*/
      PlaygroundWidget(title: "FARM-280 Update Discover", child:
          ArticleList(
              viewModelProvider: ArticleListProvider( title: "Test",
                  repository: MockArticlesRepository(articleCount: 2000)))
      )
    ];
  }
}
