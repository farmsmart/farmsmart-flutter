import 'package:farmsmart_flutter/ui/common/ActionSheet.dart';
import 'package:farmsmart_flutter/ui/common/ActionSheetListItem.dart';
import 'package:farmsmart_flutter/ui/common/Alert.dart';
import 'package:farmsmart_flutter/ui/common/ListDivider.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordTransactionHeader.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordTransactionHeaderStyles.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordTransactionListItem.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordTransactionListItemStyles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class _Constants {
  static final int firstListItem = 0;
  static final int secondListItem = 1;
  static final int thirdListItem = 2;
  static final String navCancelIcon = 'assets/icons/nav_icon_cancel.png';
  static final String navBackIcon = 'assets/icons/nav_icon_back.png';
  static final String navOptionsIcon = 'assets/icons/nav_icon_options.png';
  static final Color disabledActionColor = Color(0xFFe9eaf2);
  static final Color enabledActionSaleColor = Color(0xFF24d900);
  static final Color enabledActionCostColor = Color(0xFFff8d4f);
  static final EdgeInsets descriptionPadding = EdgeInsets.only(bottom: 60);
}

class _LocalisedStrings {
  static editRecord() => Intl.message("Edit record");

  static save() => Intl.message("Save");

  static removeRecord() => Intl.message("Remove record");

  static remove() => Intl.message("Remove");

  static removeTransactionDescription() => Intl.message(
      "Are you sure you want to remove this record? This action cannot be undone.");

  static cancel() => Intl.message("Cancel");
}

class RecordTransactionData {
  String uri;
  String amount;
  DateTime date;
  String crop;
  String description;

  RecordTransactionData({
    this.uri,
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
  String uri;
  List<RecordTransactionListItemViewModel> actions;
  TransactionType type;
  String amount;
  String description;
  bool isFilled;
  bool isEditable;
  String buttonTitle;
  final Function(RecordTransactionData) recordTransaction;
  final Function(RecordTransactionData, RecordTransactionData) editTransaction;
  final Function(RecordTransactionData) removeTransaction;

  RecordTransactionViewModel({
    this.actions,
    this.amount,
    this.buttonTitle,
    this.isFilled: false,
    this.type,
    this.isEditable: true,
    this.recordTransaction,
    this.editTransaction,
    this.removeTransaction,
    this.uri,
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

//TODO: We should refactor the whole widget in the future!!
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
  bool isEditing = false;
  bool isNewRecord = false;
  RecordTransactionData initialData;

  @override
  void initState() {
    super.initState();
    RecordTransactionViewModel viewModel = widget._viewModel;
    isNewRecord = widget._viewModel.isEditable;

    if (viewModel.actions.length <= _Constants.thirdListItem) {
      throw ('The actions inside viewModel are not correct');
    }

    initialData = RecordTransactionData(
      uri: viewModel.uri,
      amount: viewModel.amount,
      description: viewModel.actions[_Constants.thirdListItem].description,
      crop: viewModel.actions[_Constants.secondListItem].selectedItem,
      date: viewModel.actions[_Constants.firstListItem].selectedDate,
    );

    if (isNewRecord) {
      userData = RecordTransactionData(date: DateTime.now());
    } else {
      userData = RecordTransactionData(
        uri: initialData.uri,
        amount: initialData.amount,
        date: initialData.date,
        crop: initialData.crop,
        description: initialData.description,
      );
    }
  }

  Widget build(BuildContext context) {
    RecordTransactionViewModel viewModel = widget._viewModel;
    RecordTransactionStyle style = widget._style;

    if (isEditing) {
      widget._viewModel.isFilled = true;
    }

    return Scaffold(
      appBar: isEditing || isNewRecord
          ? _buildSimpleAppBar(style, context)
          : _buildEditAppBar(style, context),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          setIfRequiredFieldsAreFilled();
        },
        child: Stack(
          children: <Widget>[
            ListView(
              children: _buildContent(
                viewModel,
                style,
              ),
            ),
            _buildFooterAction(viewModel, style),
          ],
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
        onPressed: () => _dismiss(context),
        padding: style.appBarLeftMargin,
        child: Image.asset(
          _Constants.navBackIcon,
          height: style.appBarIconHeight,
          width: style.appBarIconWidth,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => _displayOptionsMenu(context, userData),
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

  void _dismiss(BuildContext context) {
    Navigator.pop(context, false);
  }

  void _apply(BuildContext context, RecordTransactionData data) {
    final viewModel = widget._viewModel;
    if (isEditing && !isNewRecord) {
      viewModel.editTransaction(initialData, data);
    } else {
      viewModel.recordTransaction(data);
    }

    _dismiss(context);
  }

  List<Widget> _buildContent(
      RecordTransactionViewModel viewModel, RecordTransactionStyle style) {
    List<Widget> listBuilder = [];

    listBuilder.add(
      RecordTransactionHeader(
          viewModel: RecordTransactionHeaderViewModel(
            isEditable: isEditing || isNewRecord,
            amount: viewModel.amount,
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
          isEditable: isEditing || isNewRecord,
          selectedDate: isEditing
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
          isEditable: isEditing || isNewRecord,
          selectedItem: isEditing
              ? userData.crop
              : viewModel.actions[_Constants.secondListItem].selectedItem,
          listOfCrops: viewModel.actions[_Constants.secondListItem].listOfCrops,
        ),
        parent: this,
      ),
    );

    listBuilder.add(ListDivider.build());

    listBuilder.add(
      Padding(
        padding: _Constants.descriptionPadding,
        child: RecordTransactionListItem(
          viewModel: RecordTransactionListItemViewModel(
            type: RecordCellType.description,
            isEditable: isEditing || isNewRecord,
            description: isEditing
                ? userData.description
                : viewModel.actions[_Constants.thirdListItem].description,
          ),
          style: RecordTransactionListItemStyles.biggerStyle,
          parent: this,
        ),
      ),
    );

    return listBuilder;
  }

  Widget _buildFooterAction(
      RecordTransactionViewModel viewModel, RecordTransactionStyle style) {
    if (isEditing || isNewRecord) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.bottomCenter,
        child: Padding(
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
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  RoundedButton _buildEnabledRoundedButton(
      RecordTransactionViewModel viewModel) {
    return RoundedButton(
      viewModel: RoundedButtonViewModel(
        title: isEditing ? _LocalisedStrings.save() : viewModel.buttonTitle,
        onTap: () => _apply(context, userData),
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

  setIfRequiredFieldsAreFilled() {
    setState(() {
      widget._viewModel.isFilled =
          (isAmountFilled && isCropFilled) || isEditing;
    });
  }

  _displayOptionsMenu(BuildContext context, RecordTransactionData data) {
    ActionSheet.present(_optionsMenu(context, data), context);
  }

  ActionSheet _optionsMenu(BuildContext context, RecordTransactionData data) {
    final actions = [
      ActionSheetListItemViewModel(
        title: _LocalisedStrings.editRecord(),
        type: ActionType.simple,
        onTap: () {
          setState(() {
            isEditing = true;
          });
        },
      ),
      ActionSheetListItemViewModel(
        title: _LocalisedStrings.removeRecord(),
        type: ActionType.simple,
        onTap: () {
          Alert.present(
            _removeConfirmationAlert(),
            context,
          );
        },
        isDestructive: true,
      ),
    ];

    final actionSheetViewModel = ActionSheetViewModel(
      actions,
      _LocalisedStrings.cancel(),
    );

    return ActionSheet(
      viewModel: actionSheetViewModel,
      style: ActionSheetStyle.defaultStyle(),
    );
  }

  Alert _removeConfirmationAlert() {
    return Alert(
      viewModel: AlertViewModel(
          cancelActionText: _LocalisedStrings.cancel(),
          confirmActionText: _LocalisedStrings.remove(),
          titleText: _LocalisedStrings.removeRecord(),
          detailText: _LocalisedStrings.removeTransactionDescription(),
          isDestructive: true,
          confirmAction: () {
            widget._viewModel.removeTransaction(initialData);
            Navigator.of(context).pop();
          }),
    );
  }
}
