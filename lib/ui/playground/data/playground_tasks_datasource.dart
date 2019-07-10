import 'package:farmsmart_flutter/data/bloc/article/ArticleListProvider.dart';
import 'package:farmsmart_flutter/data/repositories/article/implementation/MockArticlesRepository.dart';
import 'package:farmsmart_flutter/ui/discover/ArticleList.dart';
import 'package:farmsmart_flutter/ui/common/ActionSheet.dart';
import 'package:farmsmart_flutter/ui/mockData/MockActionSheetViewModel.dart';
import 'package:farmsmart_flutter/ui/playground/data/playground_data_source.dart';
import 'package:farmsmart_flutter/ui/playground/playground_widget.dart';
import 'package:farmsmart_flutter/ui/profitloss/ProfitLossHeader.dart';
import 'package:farmsmart_flutter/ui/profitloss/ProfitLossListItem.dart';
import 'package:farmsmart_flutter/ui/profitloss/mockRepositoryTryout/MockTransactionRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PlayGroundTasksDataSource implements PlaygroundDataSource {
  @override
  List<PlaygroundWidget> getList() {
    return [
      //Add Your tasks here
      PlaygroundWidget(
          title: 'TASK FARM-62 View-Prof-Loss-Statement Header',
          child: ProfitLossHeader(
              viewModel: MockProfitLossHeaderViewModel.build(),
              style: ProfitLossHeaderStyle.defaultStyle())),
      PlaygroundWidget(
        title: 'TASK FARM-62 View-Prof-Loss-Statement Negative',
        child: ProfitLossListItem(
            viewModel: MockProfitLossListItemViewModel.buildNegative(),
            style: ProfitLossItemStyle.defaultStyle()),
      ),
      PlaygroundWidget(
        title: 'TASK FARM-62 View-Prof-Loss-Statement Positive',
        child: ProfitLossListItem(
            viewModel: MockProfitLossListItemViewModel.buildPositive(),
            style: ProfitLossItemStyle.defaultStyle()),
      ),
      PlaygroundWidget(
          title: 'FARM-355 Generic Action Sheet - Type 1',
          child: Container(
            height: 350,
            child: ActionSheet(
                viewModel: MockActionSheetViewModel.buildStandard(),
                style: ActionSheetStyle.defaultStyle()),
          )),
      PlaygroundWidget(
          title: 'FARM-355 Generic Action Sheet - Type 2',
          child: Container(
            height: 420,
            child: ActionSheet(
                viewModel: MockActionSheetViewModel.buildStandardBigger(),
                style: ActionSheetStyle.defaultStyle()),
          )),
      PlaygroundWidget(
          title: 'FARM-355 Generic Action Sheet - Type 3',
          child: Container(
            height: 350,
            child: ActionSheet(
                viewModel: MockActionSheetViewModel.buildWithIcon(),
                style: ActionSheetStyle.defaultStyle()),
          )),
      PlaygroundWidget(
          title: 'FARM-355 Generic Action Sheet - Type 4',
          child: Container(
              height: 350,
              child: ActionSheet(
                  viewModel: MockActionSheetViewModel.buildWithCheckBox(),
                  style: ActionSheetStyle.defaultStyle()))),
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
