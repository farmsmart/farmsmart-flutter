import 'package:farmsmart_flutter/utils/RegExInputFormatter.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordAmount.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RecordAmountHeaderViewModel {
  String onAmountChanged;
  final Function(String) listener;
  bool isEditable;

  RecordAmountHeaderViewModel({
    this.onAmountChanged,
    this.listener,
    this.isEditable,
  });
}

class RecordAmountHeaderStyle {
  final TextStyle hintTextStyle;
  final TextStyle titleTextStyle;

  final EdgeInsets edgePadding;

  final double height;
  final int maxLines;

  RecordAmountHeaderStyle({
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
    );
  }

  factory RecordAmountHeaderStyle.defaultCostStyle() {
    return RecordAmountHeaderStyle(
      hintTextStyle: const TextStyle(
        fontSize: 72,
        fontWeight: FontWeight.w500,
        color: Color(0x4cff8d4f),
        letterSpacing: 4.32,
      ),
      titleTextStyle: const TextStyle(
        fontSize: 72,
        fontWeight: FontWeight.w500,
        color: Color(0xFFff8d4f),
        letterSpacing: 4.32,
      ),
    );
  }

  factory RecordAmountHeaderStyle.defaultSaleStyle() {
    return RecordAmountHeaderStyle.defaultCostStyle().copyWith(
      hintTextStyle: const TextStyle(
        fontSize: 72,
        fontWeight: FontWeight.w500,
        color: Color(0x4c24d900),
        letterSpacing: 4.32,
      ),
      titleTextStyle: const TextStyle(
        fontSize: 72,
        fontWeight: FontWeight.w500,
        color: Color(0xFF24d900),
        letterSpacing: 4.32,
      ),
      edgePadding: const EdgeInsets.symmetric(horizontal: 32),
      height: 137.5,
      maxLines: 1,
    );
  }
}

class RecordAmountHeader extends StatelessWidget {
  final RecordAmountHeaderViewModel _viewModel;
  final RecordAmountHeaderStyle _style;

  RecordAmountHeader({
    Key key,
    RecordAmountHeaderViewModel viewModel,
    RecordAmountHeaderStyle style,
  })  : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final _amountValidator = RegExInputFormatter.withRegex(
        '^\$|^(0|([1-9][0-9]{0,3}))(\\.[0-9]{0,2})?\$');

    return Container(
      padding: _style.edgePadding,
      height: _style.height,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _viewModel.isEditable
                    ? TextField(
                        decoration: InputDecoration(
                            hintText: _viewModel.onAmountChanged,
                            hintStyle: _style.hintTextStyle,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(0),
                            counterText: ""),
                        keyboardType: TextInputType.numberWithOptions(
                            signed: false, decimal: true),
                        textAlign: TextAlign.center,
                        style: _style.titleTextStyle,
                        inputFormatters: [_amountValidator],
                        maxLines: _style.maxLines,
                        textInputAction: TextInputAction.done,
                        onChanged: _viewModel.listener,
                      )
                    : Text(_viewModel.onAmountChanged, style: _style.titleTextStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
