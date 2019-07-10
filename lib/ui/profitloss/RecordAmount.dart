import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/ui/common/ListDivider.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:farmsmart_flutter/ui/mockData/MockRoundedButtonViewModel.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordAmountListItem.dart';
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
    switch (_viewModel.loadingStatus) {
      case LoadingStatus.LOADING:
        return Container(
            child: CircularProgressIndicator(), alignment: Alignment.center);
      case LoadingStatus.SUCCESS:
        return _buildPage(context, _viewModel);
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
        RecordAmountListItem(
            viewModel: RecordAmountListItemViewModel(
                "assets/icons/detail_icon_date.png", "Today",
                arrow: "assets/icons/chevron.png",
                title: "Date",
                selectedDate: DateTime.now())),
        ListDivider.build(),
        RecordAmountListItem(
            viewModel: RecordAmountListItemViewModel(
                "assets/icons/detail_icon_best_soil.png", "Select ...",
                arrow: "assets/icons/chevron.png",
                title: "Crop",
                listOfCrops: [
              "Okra",
              "Tomatoes",
              "Potatoes",
              "Cowpeas",
              "Sweetcorn",
              "Cucumber",
              "Beetroot"
            ])),
        ListDivider.build(),
        RecordAmountListItem(
            viewModel: RecordAmountListItemViewModel(
                "assets/icons/detail_icon_description.png",
                "Description (optional)...",
                arrow: "assets/icons/chevron.png"),
            style: biggerCellStyle),
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: RoundedButton(
                    viewModel: RoundedButtonViewModel(title: "Record Sale"),
                    style: RoundedButtonStyle.largeRoundedButtonStyle().copyWith(backgroundColor: Color(0xFFe9eaf2))),
              ),
            ],
          ),
        )
      ],
    );
  }
}
