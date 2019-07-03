import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/ui/playground/playground_widget.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordAmount.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordAmountListItem.dart';
import 'package:flutter/widgets.dart';
import 'package:farmsmart_flutter/ui/playground/data/playground_data_source.dart';

class PlayGroundTasksDataSource implements PlaygroundDataSource {
  @override
  List<PlaygroundWidget> getList() {
    return [
      //Add Your tasks here
      PlaygroundWidget(
        title: 'TASK FARM-402 Test playground widget',
        child: Text('Test play ground'),
      ),
      PlaygroundWidget(
        title: 'TASK FARM-59',
        child:  RecordAmount(viewModel: RecordAmountViewModel(LoadingStatus.SUCCESS, [
          RecordAmountListItemViewModel("assets/icons/detail_icon_date.png", "Date", detail: "Today", arrow: "assets/icons/chevron.png"),
          RecordAmountListItemViewModel("assets/icons/detail_icon_best_soil.png", "Crop", detail: "Tomatoes", arrow: "assets/icons/chevron.png"),
          RecordAmountListItemViewModel("assets/icons/detail_icon_description.png", "Description (optional)"),
        ], "00", "Record Cost")),
      )
      /* Template
      PlaygroundWidget(
        title: '#TASK NAME#',
        child: YourWidget(),
      ),*/
    ];
  }
}
