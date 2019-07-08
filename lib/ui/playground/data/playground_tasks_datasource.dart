import 'package:farmsmart_flutter/ui/playground/playground_widget.dart';
import 'package:farmsmart_flutter/ui/profitloss/ProfitLossHeader.dart';
import 'package:farmsmart_flutter/ui/profitloss/ProfitLossListItem.dart';
import 'package:farmsmart_flutter/ui/profitloss/mockRepositoryTryout/MockTransactionRepository.dart';
import 'package:flutter/widgets.dart';
import 'package:farmsmart_flutter/ui/playground/data/playground_data_source.dart';

class PlayGroundTasksDataSource implements PlaygroundDataSource {
  @override
  List<PlaygroundWidget> getList() {
    return [
      //Add Your tasks here
      PlaygroundWidget(
        title: 'TASK FARM-402 Test playground widget',
        child: ProfitLossHeader(viewModel: MockProfitLossHeaderViewModel.build(), style: ProfitLossHeaderStyle.defaultStyle())
      ),
      PlaygroundWidget(
        title: 'TASK FARM-402 Test playground widget',
        child: ProfitLossListItem(viewModel: MockProfitLossListItemViewModel.buildNegative(), style: ProfitLossItemStyle.defaultStyle()),
      ),
    PlaygroundWidget(
    title: 'TASK FARM-402 Test playground widget',
    child: ProfitLossListItem(viewModel: MockProfitLossListItemViewModel.buildPositive(), style: ProfitLossItemStyle.defaultStyle()),
    ),
      /* Template
      PlaygroundWidget(
        title: '#TASK NAME#',
        child: YourWidget(),
      ),*/
    ];
  }
}
