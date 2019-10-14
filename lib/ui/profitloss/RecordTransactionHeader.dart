import 'package:farmsmart_flutter/ui/profitloss/RecordTransaction.dart';
import 'package:farmsmart_flutter/utils/RegExInputFormatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class _Constants {
  static final amountValidator = RegExInputFormatter.withRegex(
      '^\$|^(0|([1-9][0-9]{0,3}))(\\.[0-9]{0,2})?\$');
}

class _Strings {
  static const String hint = '00';
  static const emptyString = '';
}

class RecordTransactionHeaderViewModel {
  final String amount;
  final bool isEditable;

  RecordTransactionHeaderViewModel({
    this.amount,
    this.isEditable,
  });
}

class RecordTransactionHeaderStyle {
  final TextStyle hintTextStyle;
  final TextStyle titleTextStyle;

  final EdgeInsets edgePadding;

  final double height;
  final int maxLines;

  const RecordTransactionHeaderStyle({
    this.hintTextStyle,
    this.titleTextStyle,
    this.edgePadding,
    this.height,
    this.maxLines,
  });

  RecordTransactionHeaderStyle copyWith({
    TextStyle hintTextStyle,
    TextStyle titleTextStyle,
    EdgeInsets edgePadding,
    double height,
    int maxLines,
  }) {
    return RecordTransactionHeaderStyle(
      hintTextStyle: hintTextStyle ?? this.hintTextStyle,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      edgePadding: edgePadding ?? this.edgePadding,
      height: height ?? this.height,
      maxLines: maxLines ?? this.maxLines,
    );
  }
}

class _DefaultStyle extends RecordTransactionHeaderStyle {
  final TextStyle hintTextStyle = const TextStyle(
    fontSize: 72,
    fontWeight: FontWeight.w500,
    color: Color(0x4cff8d4f),
    letterSpacing: 4.32,
  );

  final TextStyle titleTextStyle = const TextStyle(
    fontSize: 72,
    fontWeight: FontWeight.w500,
    color: Color(0xFFff8d4f),
    letterSpacing: 4.32,
  );

  final EdgeInsets edgePadding = const EdgeInsets.symmetric(horizontal: 32);
  final double height = 92;
  final int maxLines = 1;

  const _DefaultStyle({
    TextStyle hintTextStyle,
    TextStyle titleTextStyle,
    EdgeInsets edgePadding,
    double height,
    int maxLines,
  });
}

const RecordTransactionHeaderStyle _defaultStyle = const _DefaultStyle();

class RecordTransactionHeader extends StatefulWidget {
  final RecordTransactionHeaderViewModel _viewModel;
  final RecordTransactionHeaderStyle _style;
  RecordTransactionState parent;

  RecordTransactionHeader({
    Key key,
    RecordTransactionHeaderViewModel viewModel,
    RecordTransactionHeaderStyle style = _defaultStyle,
    RecordTransactionState parent,
  })  : this._viewModel = viewModel,
        this._style = style,
        this.parent = parent,
        super(key: key);

  @override
  _RecordTransactionHeaderState createState() =>
      _RecordTransactionHeaderState();
}

class _RecordTransactionHeaderState extends State<RecordTransactionHeader> {
  final FocusNode _focusNode = FocusNode();
  var hint = _Strings.hint;
  TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeAmount();
  }


  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    RecordTransactionHeaderViewModel viewModel = widget._viewModel;
    RecordTransactionHeaderStyle style = widget._style;

    return Container(
      padding: style.edgePadding,
      height: style.height,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                viewModel.isEditable
                    ? _buildAmountEditableTextField(style, viewModel)
                    : _buildAmountText(viewModel, style),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildAmountText(RecordTransactionHeaderViewModel viewModel,
      RecordTransactionHeaderStyle style) {
    return Text(viewModel.amount, style: style.titleTextStyle);
  }

  _buildAmountEditableTextField(RecordTransactionHeaderStyle style, RecordTransactionHeaderViewModel viewModel) {
    return TextField(
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: style.hintTextStyle,
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(0),
          counterText: _Strings.emptyString),
      keyboardType:
          TextInputType.numberWithOptions(signed: false, decimal: true),
      textAlign: TextAlign.center,
      style: style.titleTextStyle,
      inputFormatters: [_Constants.amountValidator],
      maxLines: style.maxLines,
      textInputAction: TextInputAction.next,
      controller: _textFieldController,
      onChanged: (amount) => _checkTextField(amount),
      focusNode: _focusNode,
      autofocus: true,
      onTap: () => clearAmountFieldHint(),
      onEditingComplete: () => resetHint(),
    );
  }

  _checkTextField(String amount) {
    setState(() {
      if (amount == "") {
        hint = _Strings.hint;
        widget.parent.isAmountFilled = false;
        widget.parent.setIfRequiredFieldsAreFilled();
      } else {
        widget.parent.userData.amount = amount;
        widget.parent.isAmountFilled = true;
        widget.parent.setIfRequiredFieldsAreFilled();
      }
    });
  }

  clearAmountFieldHint() {
    setState(() {
      if (_textFieldController.text == _Strings.emptyString) {
        hint = _Strings.emptyString;
      } else {
        hint = _Strings.hint;
      }
    });
  }

  resetHint() {
    setState(() {
      if (_textFieldController.text == _Strings.emptyString) {
        hint = _Strings.hint;
      } else {
        widget.parent.userData.amount = _textFieldController.text;
        widget.parent.isAmountFilled = true;
        FocusScope.of(context).unfocus();
      }
    });
  }

  void _initializeAmount() {
    var amount = widget._viewModel.amount;
    if(amount != null && amount.isNotEmpty) {
      _textFieldController.text = widget._viewModel.amount;
    }
  }
}
