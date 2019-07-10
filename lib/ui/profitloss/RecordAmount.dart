import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/ui/common/ListDivider.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:farmsmart_flutter/ui/mockData/MockRoundedButtonViewModel.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordAmountDate.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordAmountHeader.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordAmountListItem.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:flutter/material.dart';

class RecordAmountViewModel {
  LoadingStatus loadingStatus;
  List<RecordAmountListItemViewModel> actions;
  String amount;
  String buttonTitle;

  RecordAmountViewModel(
      this.loadingStatus, this.actions, this.amount, this.buttonTitle);
}

class RecordAmount extends StatelessWidget {
  final RecordAmountViewModel _viewModel;

  const RecordAmount({Key key, RecordAmountViewModel viewModel})
      : this._viewModel = viewModel,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context, _viewModel),
    );
  }

  Widget _buildBody(BuildContext context, RecordAmountViewModel viewModel) {
    switch (viewModel.loadingStatus) {
      case LoadingStatus.LOADING:
        return Container(
            child: CircularProgressIndicator(), alignment: Alignment.center);
      case LoadingStatus.SUCCESS:
        return _buildPage(context, viewModel);
      case LoadingStatus.ERROR:
        return Text(Strings.errorString);
    }
  }

  Widget _buildPage(BuildContext context, RecordAmountViewModel viewModel) {
    return ListView(
      children: <Widget>[
        RecordAmountHeader(
            viewModel: RecordAmountHeaderViewModel(viewModel.amount),
            style: RecordAmountHeaderStyle.defaultSaleStyle()),
        RecordAmountPicker(
            viewModel: RecordAmountPickerViewModel(
                "assets/icons/detail_icon_date.png",
                "Date",
                "Today",
                "assets/icons/chevron.png",
                selectedDate: DateTime.now())),
        ListDivider.build(),
        RecordAmountPicker(
            viewModel: RecordAmountPickerViewModel(
                "assets/icons/detail_icon_best_soil.png",
                "Crop",
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
              ]
               )),
        ListDivider.build(),
        /*RecordAmountPicker(
            viewModel: RecordAmountPickerViewModel(
                "assets/icons/detail_icon_date.png",
                "Date",
                "Today",
                "assets/icons/chevron.png",
                DateTime.now())),*/
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: RoundedButton(
                    viewModel: MockRoundedButtonViewModel.buildLarge(),
                    style: RoundedButtonStyle.largeRoundedButtonStyle()),
              ),
            ],
          ),
        )
      ],
    );
  }
  


    /*return HeaderAndFooterListView.builder(
        itemCount: viewModel.actions.length,
        itemBuilder: (BuildContext context, int index) {
          return RecordAmountListItem(viewModel: viewModel.actions[index],
              style: index+1 != viewModel.actions.length ? RecordAmountListItemStyle.defaultStyle() : RecordAmountListItemStyle.fillStype(),
              currentAction: index,
              numberOfActions: viewModel.actions.length);
        },
        physics: ScrollPhysics(),
        shrinkWrap: true,
        header: RecordAmountHeader(viewModel: RecordAmountHeaderViewModel(viewModel.amount), style: RecordAmountHeaderStyle.defaultSaleStyle()),
        footer: RoundedButton(viewModel: RoundedButtonViewModel(title: viewModel.buttonTitle), style: RoundedButtonStyle.largeRoundedButtonStyle())
    );*/
}
