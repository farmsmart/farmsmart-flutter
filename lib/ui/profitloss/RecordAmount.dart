import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/ui/common/ListDivider.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:farmsmart_flutter/ui/mockData/MockRecordAmountViewModel.dart';
import 'package:farmsmart_flutter/ui/mockData/MockRoundedButtonViewModel.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordAmountListItem.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordAmountHeader.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordAmountListItem.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordAmountListItemStyles.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:flutter/material.dart';

class RecordAmountViewModel {
  LoadingStatus loadingStatus;
  List<RecordAmountListItemViewModel> actions;
  String amount;
  String buttonTitle;
  bool isFilled;
  Function onTap;

  RecordAmountViewModel(
      {this.loadingStatus,
      this.actions,
      this.amount,
      this.buttonTitle,
      this.isFilled: false,
      this.onTap});
}

class RecordAmount extends StatefulWidget {
  final RecordAmountViewModel _viewModel;

  RecordAmount({Key key, RecordAmountViewModel viewModel})
      : this._viewModel = viewModel,
        super(key: key);

  @override
  RecordAmountState createState() => RecordAmountState();
}

class RecordAmountState extends State<RecordAmount> {
  String selectedCrop;
  bool amoundIsFilled = false;
  bool cropIsFilled = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      widget._viewModel.isFilled = false;
    });
  }

  Widget build(BuildContext context) {
    switch (widget._viewModel.loadingStatus) {
      case LoadingStatus.LOADING:
        return Container(
            child: CircularProgressIndicator(), alignment: Alignment.center);
      case LoadingStatus.SUCCESS:
        return _buildPage(context, widget._viewModel);
      case LoadingStatus.ERROR:
        return Text(Strings.errorString);
    }
  }

  Widget _buildPage(BuildContext context, RecordAmountViewModel viewModel) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        checkIfFilled();
      },
      child: ListView(
        children: <Widget>[
          RecordAmountHeader(viewModel: RecordAmountHeaderViewModel(
                  listener: (amount) {
                    amoundIsFilled = true;
                    checkIfFilled();
                  }),
              style: RecordAmountHeaderStyle.defaultSaleStyle()),
          RecordAmountListItem(
              viewModel:
              RecordAmountListItemViewModel(
                  icon: viewModel.actions[0].icon,
                  hint: viewModel.actions[0].hint,
                  arrow: viewModel.actions[0].arrow,
                  title: viewModel.actions[0].title,
                  selectedDate: viewModel.actions[0].selectedDate),
              parent: this),
          ListDivider.build(),
          RecordAmountListItem(
              viewModel: RecordAmountListItemViewModel(
                  icon: viewModel.actions[1].icon,
                  hint: viewModel.actions[1].hint,
                  selectedItem: selectedCrop,
                  arrow: viewModel.actions[1].arrow,
                  title: viewModel.actions[1].title,
                  listOfCrops: viewModel.actions[1].listOfCrops,
                  listener: (crop) {
                    cropIsFilled = true;
                    checkIfFilled();
                  }),
              parent: this),
          ListDivider.build(),
          RecordAmountListItem(
              viewModel: RecordAmountListItemViewModel(
                  icon: viewModel.actions[2].icon,
                  hint: viewModel.actions[2].hint,
                  arrow: viewModel.actions[2].arrow),
              style: RecordAmountListItemStyles.biggerStyle,
              parent: this),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: !widget._viewModel.isFilled
                      ? RoundedButton(
                          viewModel: RoundedButtonViewModel(
                              title: "Record Sale", onTap: null),
                          style: RoundedButtonStyle.largeRoundedButtonStyle()
                              .copyWith(backgroundColor: Color(0xFFe9eaf2)))
                      : RoundedButton(
                          viewModel: RoundedButtonViewModel(
                              title: "Record Sale",
                              onTap: widget._viewModel.onTap),
                          style: RoundedButtonStyle.largeRoundedButtonStyle()
                              .copyWith(backgroundColor: Color(0xFF24d900))),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  checkIfFilled() {
    setState(() {
      if (amoundIsFilled && cropIsFilled) {
        widget._viewModel.isFilled = true;
      } else {
        widget._viewModel.isFilled = false;
      }
    });
  }
}
