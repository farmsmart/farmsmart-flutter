import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/ui/common/ListDivider.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordAmountHeaderStyles.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordAmountListItem.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordAmountHeader.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordAmountListItemStyles.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:flutter/material.dart';

class _Constants {
  static final int firstListItem = 0;
  static final int secondListItem = 1;
  static final int thirdListItem = 2;
}

class RecordData {
  String amount;
  DateTime date;
  String crop;
  String description;

  RecordData({this.amount, this.date, this.crop, this.description});
}

enum RecordType {
  cost,
  sale,
}

class RecordAmountViewModel {
  LoadingStatus loadingStatus;
  List<RecordAmountListItemViewModel> actions;
  RecordType type;
  String amount;
  String description;
  bool isFilled;
  bool isEditable;
  Function onTap;
  String buttonTitle;

  RecordAmountViewModel({
    this.loadingStatus,
    this.actions,
    this.amount,
    this.buttonTitle,
    this.isFilled: false,
    this.onTap,
    this.type,
    this.isEditable: true,
  });
}

class RecordAmountStyle {
  final EdgeInsets buttonEdgePadding;

  final EdgeInsets appBarLeftMargin;
  final EdgeInsets appBarRightMargin;

  final double headerLineSpace;
  final double appBarElevation;
  final double appBarIconHeight;
  final double appBarIconWidth;

  const RecordAmountStyle({
    this.buttonEdgePadding,
    this.appBarLeftMargin,
    this.appBarRightMargin,
    this.headerLineSpace,
    this.appBarElevation,
    this.appBarIconHeight,
    this.appBarIconWidth,
  });

  RecordAmountStyle copyWith({
    EdgeInsets buttonEdgePadding,
    EdgeInsets appBarLeftMargin,
    EdgeInsets appBarRightMargin,
    double headerLineSpace,
    double appBarElevation,
    double appBarIconHeight,
    double appBarIconWidth,
  }) {
    return RecordAmountStyle(
      buttonEdgePadding: buttonEdgePadding ?? this.buttonEdgePadding,
      appBarLeftMargin: appBarLeftMargin ?? this.appBarLeftMargin,
      appBarRightMargin: appBarRightMargin ?? this.appBarRightMargin,
      headerLineSpace: headerLineSpace ?? this.headerLineSpace,
      appBarElevation: appBarElevation ?? this.appBarElevation,
      appBarIconHeight: appBarIconHeight ?? this.appBarIconHeight,
      appBarIconWidth: appBarIconWidth ?? this.appBarIconWidth,
    );
  }
}

class _DefaultStyle extends RecordAmountStyle {
  final EdgeInsets buttonEdgePadding = const EdgeInsets.all(32.0);

  final EdgeInsets appBarLeftMargin = const EdgeInsets.only(left: 31);
  final EdgeInsets appBarRightMargin = const EdgeInsets.only(right: 0);

  final double headerLineSpace = 16;

  final double appBarElevation = 0;
  final double appBarIconHeight = 20;
  final double appBarIconWidth = 20.5;

  const _DefaultStyle({
    EdgeInsets buttonEdgePadding,
    EdgeInsets appBarLeftMargin,
    EdgeInsets appBarRightMargin,
    double headerLineSpace,
    double appBarElevation,
    double appBarIconHeight,
    double appBarIconWidth,
  });
}

const RecordAmountStyle _defaultStyle = const _DefaultStyle();

class RecordAmount extends StatefulWidget {
  final RecordAmountViewModel _viewModel;
  final RecordAmountStyle _style;

  RecordAmount({
    Key key,
    RecordAmountViewModel viewModel,
    RecordAmountStyle style = _defaultStyle,
  })  : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  RecordAmountState createState() => RecordAmountState();
}

class RecordAmountState extends State<RecordAmount> {
  String description;
  String selectedCrop;
  DateTime selectedDate = DateTime.now();
  String amount;
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
          child: CircularProgressIndicator(),
          alignment: Alignment.center,
        );
      case LoadingStatus.SUCCESS:
        return _buildPage(
          context,
          widget._viewModel,
          widget._style,
        );
      case LoadingStatus.ERROR:
        return Text(Strings.errorString);
    }
  }

  Widget _buildPage(BuildContext context, RecordAmountViewModel viewModel,
      RecordAmountStyle style) {
    return Scaffold(
      appBar: viewModel.isEditable
          ? _buildSimpleAppBar(style, context)
          : _buildEditAppBar(style, context),
      body: GestureDetector(
        onTap: () {
          //FocusScope.of(context).requestFocus(FocusNode());
          FocusScope.of(context).detach();
          checkIfFilled();
        },
        child: ListView(
          children: _buildContent(
            viewModel,
            style,
          ),
        ),
      ),
    );
  }

  AppBar _buildSimpleAppBar(RecordAmountStyle style, BuildContext context) {
    return AppBar(
      elevation: style.appBarElevation,
      leading: FlatButton(
        onPressed: () => Navigator.pop(context, false),
        padding: style.appBarLeftMargin,
        child: Image.asset(
          'assets/icons/nav_icon_cancel.png',
          height: style.appBarIconHeight,
          width: style.appBarIconWidth,
        ),
      ),
    );
  }

  AppBar _buildEditAppBar(RecordAmountStyle style, BuildContext context) {
    return AppBar(
      elevation: style.appBarElevation,
      leading: FlatButton(
        onPressed: () => Navigator.of(context).pop(false),
        padding: style.appBarLeftMargin,
        child: Image.asset(
          'assets/icons/nav_icon_back.png',
          height: style.appBarIconHeight,
          width: style.appBarIconWidth,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => null,
          padding: style.appBarRightMargin,
          child: Image.asset(
            'assets/icons/nav_icon_options.png',
            height: style.appBarIconHeight,
            width: style.appBarIconWidth,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildContent(
      RecordAmountViewModel viewModel, RecordAmountStyle style) {
    List<Widget> listBuilder = [];

    listBuilder.add(
      RecordAmountHeader(
        viewModel: RecordAmountHeaderViewModel(
          isEditable: viewModel.isEditable,
          onAmountChanged: viewModel.amount,
        ),
        style: viewModel.type == RecordType.sale
            ? RecordAmountHeaderStyles.defaultSaleStyle
            : RecordAmountHeaderStyles.defaultCostStyle,
      parent: this),
    );

    listBuilder.add(SizedBox(height: style.headerLineSpace));

    listBuilder.add(
      RecordAmountListItem(
        viewModel: RecordAmountListItemViewModel(
          type: RecordCellType.pickDate,
          isEditable: viewModel.isEditable,
          selectedDate: viewModel.isEditable
              ? selectedDate
              : viewModel.actions[_Constants.firstListItem].selectedDate,
        ),
        parent: this,
      ),
    );

    listBuilder.add(ListDivider.build());

    listBuilder.add(
      RecordAmountListItem(
        viewModel: RecordAmountListItemViewModel(
          type: RecordCellType.pickItem,
          isEditable: viewModel.isEditable,
          selectedItem: viewModel.isEditable
              ? selectedCrop
              : viewModel.actions[_Constants.secondListItem].selectedItem,
          listOfCrops: viewModel.actions[_Constants.secondListItem].listOfCrops,
        ),
        parent: this,
      ),
    );

    listBuilder.add(ListDivider.build());

    listBuilder.add(
      RecordAmountListItem(
        viewModel: RecordAmountListItemViewModel(
          type: RecordCellType.description,
          isEditable: viewModel.isEditable,
          description: viewModel.isEditable
              ? description
              : viewModel.actions[_Constants.thirdListItem].description,
        ),
        style: RecordAmountListItemStyles.biggerStyle,
        parent: this,
      ),
    );

    if (viewModel.isEditable) {
      listBuilder.add(_buildFooter(viewModel, style));
    }
    return listBuilder;
  }

  Padding _buildFooter(
      RecordAmountViewModel viewModel, RecordAmountStyle style) {
    return Padding(
      padding: style.buttonEdgePadding,
      child: Row(
        children: <Widget>[
          Expanded(
            child: !widget._viewModel.isFilled
                ? RoundedButton(
                    viewModel: RoundedButtonViewModel(
                        title: viewModel.buttonTitle, onTap: null),
                    style: RoundedButtonStyle.largeRoundedButtonStyle()
                        .copyWith(backgroundColor: Color(0xFFe9eaf2)),
                  )
                : RoundedButton(
                    viewModel: RoundedButtonViewModel(
                        title: viewModel.buttonTitle, onTap: saveData),
                    style: viewModel.type == RecordType.sale
                        ? RoundedButtonStyle.largeRoundedButtonStyle()
                            .copyWith(backgroundColor: Color(0xFF24d900))
                        : RoundedButtonStyle.largeRoundedButtonStyle()
                            .copyWith(backgroundColor: Color(0xFFff8d4f)),
                  ),
          ),
        ],
      ),
    );
  }

  checkIfFilled() {
    print(amount);
    print(selectedCrop);
    setState(() {
      if (amoundIsFilled && cropIsFilled) {
        widget._viewModel.isFilled = true;
      } else {
        widget._viewModel.isFilled = false;
      }
    });
  }

  saveData() {
      RecordData save = RecordData(
        amount: amount,
        date: selectedDate,
        crop: selectedCrop,
        description: description,
      );

      //TODO: Temporal print
      print(save.amount+" / "+save.date.toIso8601String()+" / "+save.crop+" / "+save.description);
  }
}
