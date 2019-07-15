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

enum RecordType {
  cost,
  sale,
}

class RecordAmountViewModel {
  LoadingStatus loadingStatus;
  List<RecordAmountListItemViewModel> actions;
  String amount;
  String buttonTitle;
  bool isFilled;
  Function onTap;
  RecordType type;
  bool isEditable;
  String description;

  RecordAmountViewModel(
      {this.loadingStatus,
      this.actions,
      this.amount: "00",
      this.buttonTitle,
      this.isFilled: false,
      this.onTap,
      this.type,
      this.isEditable: true});
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
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          leading: FlatButton(
              onPressed: () => Navigator.pop(context, false),
              padding: EdgeInsets.only(left: 31.5),
              child: Image.asset('assets/icons/nav_icon_back.png',
                  height: 20, width: 20.5)),
      actions: <Widget>[FlatButton(
          onPressed: () => null,
          //padding: EdgeInsets.only(right: 25),
          child: Image.asset('assets/icons/nav_icon_options.png',
              height: 20, width: 20.5))],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          checkIfFilled();
        },
        child: ListView(
          children: _buildContent(viewModel),
        ),
      ),
    );
  }

  List<Widget> _buildContent(RecordAmountViewModel viewModel) {
    List<Widget> listBuilder = [];

    listBuilder.add(SizedBox(height: 40));
    listBuilder.add(RecordAmountHeader(
        viewModel: RecordAmountHeaderViewModel(
            isEditable: viewModel.isEditable,
            amount: viewModel.amount,
            listener: (amount) {
              amoundIsFilled = true;
              checkIfFilled();
            }),
        style: viewModel.type == RecordType.sale
            ? RecordAmountHeaderStyle.defaultSaleStyle()
            : RecordAmountHeaderStyle.defaultCostStyle()));

    listBuilder.add(SizedBox(height: 34));

    listBuilder.add(RecordAmountListItem(
        viewModel: RecordAmountListItemViewModel(
            isEditable: viewModel.isEditable,
            icon: viewModel.actions[0].icon,
            hint: viewModel.actions[0].hint,
            arrow: viewModel.actions[0].arrow,
            title: viewModel.actions[0].title,
            selectedDate: viewModel.actions[0].selectedDate),
        parent: this));

    listBuilder.add(ListDivider.build());

    listBuilder.add(RecordAmountListItem(
        viewModel: RecordAmountListItemViewModel(
            isEditable: viewModel.isEditable,
            icon: viewModel.actions[1].icon,
            hint: viewModel.actions[1].hint,
            selectedItem: viewModel.isEditable
                ? selectedCrop
                : viewModel.actions[1].selectedItem,
            arrow: viewModel.actions[1].arrow,
            title: viewModel.actions[1].title,
            listOfCrops: viewModel.actions[1].listOfCrops,
            listener: (crop) {
              cropIsFilled = true;
              checkIfFilled();
            }),
        parent: this));

    listBuilder.add(ListDivider.build());

    listBuilder.add(RecordAmountListItem(
        viewModel: RecordAmountListItemViewModel(
            isEditable: viewModel.isEditable,
            icon: viewModel.actions[2].icon,
            hint: viewModel.actions[2].hint,
            description: viewModel.actions[2].description,
            arrow: viewModel.actions[2].arrow),
        style: RecordAmountListItemStyles.biggerStyle,
        parent: this));

    if (viewModel.isEditable) {
      listBuilder.add(_buildFooter(viewModel));
    }

    return listBuilder;
  }

  Padding _buildFooter(RecordAmountViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: !widget._viewModel.isFilled
                ? RoundedButton(
                    viewModel: RoundedButtonViewModel(
                        title: viewModel.buttonTitle, onTap: null),
                    style: RoundedButtonStyle.largeRoundedButtonStyle()
                        .copyWith(backgroundColor: Color(0xFFe9eaf2)))
                : RoundedButton(
                    viewModel: RoundedButtonViewModel(
                        title: viewModel.buttonTitle,
                        onTap: widget._viewModel.onTap),
                    style: viewModel.type == RecordType.sale
                        ? RoundedButtonStyle.largeRoundedButtonStyle()
                            .copyWith(backgroundColor: Color(0xFF24d900))
                        : RoundedButtonStyle.largeRoundedButtonStyle()
                            .copyWith(backgroundColor: Color(0xFFff8d4f))),
          ),
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
