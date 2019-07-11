import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/ui/common/ListDivider.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
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

  RecordAmountViewModel(this.loadingStatus, this.actions, this.amount, this.buttonTitle, {this.isFilled : false});
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
  int number = 0;
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
      onTap: ()  {
        FocusScope.of(context).requestFocus(FocusNode());
        checkIfFilled();
      },
      child: ListView(
          children: <Widget>[
            RecordAmountHeader(
                viewModel: RecordAmountHeaderViewModel(viewModel.amount, listener: (amount) {
                  amoundIsFilled = true;
                  checkIfFilled();
                }),
                style: RecordAmountHeaderStyle.defaultSaleStyle(), parent: this),
            RecordAmountListItem(
                viewModel: RecordAmountListItemViewModel(
                    "assets/icons/detail_icon_date.png", "Today",
                    arrow: "assets/icons/chevron.png",
                    title: "Date",
                    selectedDate: DateTime.now()), parent: this),
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
                ], listener: (crop) {
                      cropIsFilled = true;
                      checkIfFilled();
                }), parent: this),
            ListDivider.build(),
            RecordAmountListItem(
                viewModel: RecordAmountListItemViewModel(
                    "assets/icons/detail_icon_description.png",
                    "Description (optional)...",
                    arrow: "assets/icons/chevron.png"),
                style: RecordAmountListItemStyles.biggerStyle, parent: this),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RoundedButton(
                      viewModel: RoundedButtonViewModel(title: "Record Sale"),
                      style: widget._viewModel.isFilled == false
                          ? RoundedButtonStyle.largeRoundedButtonStyle()
                              .copyWith(backgroundColor: Color(0xFFe9eaf2))
                          : RoundedButtonStyle.largeRoundedButtonStyle()
                              .copyWith(backgroundColor: Color(0xFF24d900)),
                    ),
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
    print(amoundIsFilled);
    print(cropIsFilled);
  }
}
