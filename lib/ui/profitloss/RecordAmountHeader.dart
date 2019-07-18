import 'package:farmsmart_flutter/utils/RegExInputFormatter.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordAmount.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class _Constants {
  static final amountValidator = RegExInputFormatter.withRegex(
      '^\$|^(0|([1-9][0-9]{0,3}))(\\.[0-9]{0,2})?\$');
}

class _Strings {
  static final HINT = Intl.message("00");
  static final EMPTY_STRING = "";
}

class RecordAmountHeaderViewModel {
  String onAmountChanged;
  bool isEditable;

  RecordAmountHeaderViewModel({
    this.onAmountChanged,
    this.isEditable,
  });
}

class RecordAmountHeaderStyle {
  final TextStyle hintTextStyle;
  final TextStyle titleTextStyle;

  final EdgeInsets edgePadding;

  final double height;
  final int maxLines;

  const RecordAmountHeaderStyle({
    this.hintTextStyle,
    this.titleTextStyle,
    this.edgePadding,
    this.height,
    this.maxLines,
  });

  RecordAmountHeaderStyle copyWith({
    TextStyle hintTextStyle,
    TextStyle titleTextStyle,
    EdgeInsets edgePadding,
    double height,
    int maxLines,
  }) {
    return RecordAmountHeaderStyle(
      hintTextStyle: hintTextStyle ?? this.hintTextStyle,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      edgePadding: edgePadding ?? this.edgePadding,
      height: height ?? this.height,
      maxLines: maxLines ?? this.maxLines,
    );
  }
}

class _DefaultStyle extends RecordAmountHeaderStyle {
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
  final double height = 137.5;
  final int maxLines = 1;

  const _DefaultStyle({
    TextStyle hintTextStyle,
    TextStyle titleTextStyle,
    EdgeInsets edgePadding,
    double height,
    int maxLines,
  });
}

const RecordAmountHeaderStyle _defaultStyle = const _DefaultStyle();

class RecordAmountHeader extends StatefulWidget {
  final RecordAmountHeaderViewModel _viewModel;
  final RecordAmountHeaderStyle _style;
  RecordAmountState parent;

  RecordAmountHeader({
    Key key,
    RecordAmountHeaderViewModel viewModel,
    RecordAmountHeaderStyle style = _defaultStyle,
    RecordAmountState parent,
  })  : this._viewModel = viewModel,
        this._style = style,
        this.parent = parent,
        super(key: key);

  @override
  _RecordAmountHeaderState createState() => _RecordAmountHeaderState();
}

class _RecordAmountHeaderState extends State<RecordAmountHeader> {
  final _textFieldController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  var hint = _Strings.HINT;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    RecordAmountHeaderViewModel viewModel = widget._viewModel;
    RecordAmountHeaderStyle style = widget._style;

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
                    ? TextField(
                        decoration: InputDecoration(
                            hintText: hint,
                            hintStyle: style.hintTextStyle,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(0),
                            counterText: _Strings.EMPTY_STRING),
                        keyboardType: TextInputType.numberWithOptions(
                            signed: false, decimal: true),
                        textAlign: TextAlign.center,
                        style: style.titleTextStyle,
                        inputFormatters: [_Constants.amountValidator],
                        maxLines: style.maxLines,
                        textInputAction: TextInputAction.next,
                        controller: _textFieldController,
                        onChanged: (amount) => _checkTextField(amount),
                        focusNode: _focusNode,
                        onTap: () => cleanField(),
                        onEditingComplete: () => resetHint(),
                      )
                    : Text(viewModel.onAmountChanged,
                        style: style.titleTextStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _checkTextField(String amount) {
    setState(() {
      if (amount == "") {
        hint = _Strings.HINT;
        widget.parent.amoundIsFilled = false;
        widget.parent.checkIfFilled();
      } else {
        widget.parent.amount = amount;
        widget.parent.amoundIsFilled = true;
        widget.parent.checkIfFilled();
      }
    });
  }

  cleanField() {
    setState(() {
      if (_textFieldController.text == _Strings.EMPTY_STRING) {
        hint = _Strings.EMPTY_STRING;
      } else {
        hint = _Strings.HINT;
      }
    });
  }

  resetHint() {
    setState(() {
      if (_textFieldController.text == _Strings.EMPTY_STRING) {
        hint = _Strings.HINT;
      } else {
        widget.parent.amount = _textFieldController.text;
        widget.parent.amoundIsFilled = true;
        FocusScope.of(context).detach();
      }
    });
  }
}
