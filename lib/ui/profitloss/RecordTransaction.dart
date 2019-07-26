import 'package:farmsmart_flutter/ui/common/ListDivider.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordTransactionHeader.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordTransactionHeaderStyles.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordTransactionListItem.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordTransactionListItemStyles.dart';
import 'package:flutter/material.dart';

class _Constants {
  static final int firstListItem = 0;
  static final int secondListItem = 1;
  static final int thirdListItem = 2;
  static final String navCancelIcon = 'assets/icons/nav_icon_cancel.png';
  static final String navBackIcon = 'assets/icons/nav_icon_back.png';
  static final String navOptionsIcon = 'assets/icons/nav_icon_options.png';
  static final String EMPTY_STRING = "";
  static final Color disabledActionColor = Color(0xFFe9eaf2);
  static final Color enabledActionSaleColor = Color(0xFF24d900);
  static final Color enabledActionCostColor = Color(0xFFff8d4f);
}

class RecordTransactionData {
  String amount;
  DateTime date;
  String crop;
  String description;

  RecordTransactionData({
    this.amount,
    this.date,
    this.crop,
    this.description,
  });
}

enum TransactionType {
  cost,
  sale,
}

class RecordTransactionViewModel {
  List<RecordTransactionListItemViewModel> actions;
  TransactionType type;
  String amount;
  String description;
  bool isFilled;
  bool isEditable;
  String buttonTitle;
  final Function(RecordTransactionData) onTransactionRecorded;

  RecordTransactionViewModel({
    this.actions,
    this.amount,
    this.buttonTitle,
    this.isFilled: false,
    this.type,
    this.isEditable: true,
    this.onTransactionRecorded,
  });
}

class RecordTransactionStyle {
  final EdgeInsets buttonEdgePadding;

  final EdgeInsets appBarLeftMargin;
  final EdgeInsets appBarRightMargin;

  final double headerLineSpace;
  final double appBarElevation;
  final double appBarIconHeight;
  final double appBarIconWidth;

  const RecordTransactionStyle({
    this.buttonEdgePadding,
    this.appBarLeftMargin,
    this.appBarRightMargin,
    this.headerLineSpace,
    this.appBarElevation,
    this.appBarIconHeight,
    this.appBarIconWidth,
  });

  RecordTransactionStyle copyWith({
    EdgeInsets buttonEdgePadding,
    EdgeInsets appBarLeftMargin,
    EdgeInsets appBarRightMargin,
    double headerLineSpace,
    double appBarElevation,
    double appBarIconHeight,
    double appBarIconWidth,
  }) {
    return RecordTransactionStyle(
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

class _DefaultStyle extends RecordTransactionStyle {
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

const RecordTransactionStyle _defaultStyle = const _DefaultStyle();

class RecordTransaction extends StatefulWidget {
  final RecordTransactionViewModel _viewModel;
  final RecordTransactionStyle _style;

  RecordTransaction({
    Key key,
    RecordTransactionViewModel viewModel,
    RecordTransactionStyle style = _defaultStyle,
  })  : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  RecordTransactionState createState() => RecordTransactionState();
}

class RecordTransactionState extends State<RecordTransaction> {
  RecordTransactionData userData = RecordTransactionData(date: DateTime.now());
  bool isAmountFilled = false;
  bool isCropFilled = false;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    RecordTransactionViewModel viewModel = widget._viewModel;
    RecordTransactionStyle style = widget._style;

    return Scaffold(
      appBar: viewModel.isEditable
          ? _buildSimpleAppBar(style, context)
          : _buildEditAppBar(style, context),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          setRequiredFieldsAreFilled();
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

  AppBar _buildSimpleAppBar(
      RecordTransactionStyle style, BuildContext context) {
    return AppBar(
      elevation: style.appBarElevation,
      leading: FlatButton(
        onPressed: () => Navigator.pop(context, false),
        padding: style.appBarLeftMargin,
        child: Image.asset(
          _Constants.navCancelIcon,
          height: style.appBarIconHeight,
          width: style.appBarIconWidth,
        ),
      ),
    );
  }

  AppBar _buildEditAppBar(RecordTransactionStyle style, BuildContext context) {
    return AppBar(
      elevation: style.appBarElevation,
      leading: FlatButton(
        onPressed: () => Navigator.of(context).pop(false),
        padding: style.appBarLeftMargin,
        child: Image.asset(
          _Constants.navBackIcon,
          height: style.appBarIconHeight,
          width: style.appBarIconWidth,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => null,
          padding: style.appBarRightMargin,
          child: Image.asset(
            _Constants.navOptionsIcon,
            height: style.appBarIconHeight,
            width: style.appBarIconWidth,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildContent(
      RecordTransactionViewModel viewModel, RecordTransactionStyle style) {
    List<Widget> listBuilder = [];

    listBuilder.add(
      RecordTransactionHeader(
          viewModel: RecordTransactionHeaderViewModel(
            isEditable: viewModel.isEditable,
            onAmountChanged: viewModel.amount,
          ),
          style: viewModel.type == TransactionType.sale
              ? RecordTransactionHeaderStyles.defaultSaleStyle
              : RecordTransactionHeaderStyles.defaultCostStyle,
          parent: this),
    );

    listBuilder.add(SizedBox(height: style.headerLineSpace));

    listBuilder.add(
      RecordTransactionListItem(
        viewModel: RecordTransactionListItemViewModel(
          type: RecordCellType.pickDate,
          isEditable: viewModel.isEditable,
          selectedDate: viewModel.isEditable
              ? userData.date
              : viewModel.actions[_Constants.firstListItem].selectedDate,
        ),
        parent: this,
      ),
    );

    listBuilder.add(ListDivider.build());

    listBuilder.add(
      RecordTransactionListItem(
        viewModel: RecordTransactionListItemViewModel(
          type: RecordCellType.pickItem,
          isEditable: viewModel.isEditable,
          selectedItem: viewModel.isEditable
              ? userData.crop
              : viewModel.actions[_Constants.secondListItem].selectedItem,
          listOfCrops: viewModel.actions[_Constants.secondListItem].listOfCrops,
        ),
        parent: this,
      ),
    );

    listBuilder.add(ListDivider.build());

    listBuilder.add(
      RecordTransactionListItem(
        viewModel: RecordTransactionListItemViewModel(
          type: RecordCellType.description,
          isEditable: viewModel.isEditable,
          description: viewModel.isEditable
              ? userData.description
              : viewModel.actions[_Constants.thirdListItem].description,
        ),
        style: RecordTransactionListItemStyles.biggerStyle,
        parent: this,
      ),
    );

    if (viewModel.isEditable) {
      listBuilder.add(_buildFooterAction(viewModel, style));
    }
    return listBuilder;
  }

  Padding _buildFooterAction(
      RecordTransactionViewModel viewModel, RecordTransactionStyle style) {
    return Padding(
      padding: style.buttonEdgePadding,
      child: Row(
        children: <Widget>[
          Expanded(
            child: !widget._viewModel.isFilled
                ? _buildDisabledRoundedButton(viewModel)
                : _buildEnabledRoundedButton(viewModel),
          ),
        ],
      ),
    );
  }

  RoundedButton _buildEnabledRoundedButton(
      RecordTransactionViewModel viewModel) {
    return RoundedButton(
      viewModel: RoundedButtonViewModel(
        title: viewModel.buttonTitle,
        onTap: () => viewModel.onTransactionRecorded(userData),
      ),
      style: viewModel.type == TransactionType.sale
          ? RoundedButtonStyle.largeRoundedButtonStyle().copyWith(
              backgroundColor: _Constants.enabledActionSaleColor,
            )
          : RoundedButtonStyle.largeRoundedButtonStyle().copyWith(
              backgroundColor: _Constants.enabledActionCostColor,
            ),
    );
  }

  RoundedButton _buildDisabledRoundedButton(
      RecordTransactionViewModel viewModel) {
    return RoundedButton(
      viewModel:
          RoundedButtonViewModel(title: viewModel.buttonTitle, onTap: null),
      style: RoundedButtonStyle.largeRoundedButtonStyle().copyWith(
        backgroundColor: _Constants.disabledActionColor,
      ),
    );
  }

  setRequiredFieldsAreFilled() {
    setState(() {
      widget._viewModel.isFilled = isAmountFilled && isCropFilled;
    });
  }
}
