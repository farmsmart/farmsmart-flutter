
import 'package:flutter/material.dart';

class RecordAmountHeaderViewModel {
  String amount;

  RecordAmountHeaderViewModel(this.amount);
}

class RecordAmountHeaderStyle {
  final TextStyle hintTextStyle;
  final TextStyle titleTextStyle;

  RecordAmountHeaderStyle({this.hintTextStyle, this.titleTextStyle});

  factory RecordAmountHeaderStyle.defaultCostStyle() {
    return RecordAmountHeaderStyle(
      hintTextStyle: const TextStyle(fontSize: 72, fontWeight: FontWeight.w700, color: Color(0x4cff8d4f)),
      titleTextStyle: const TextStyle(fontSize: 72, fontWeight: FontWeight.w700, color: Color(0xFFff8d4f))
    );
  }

  factory RecordAmountHeaderStyle.defaultSaleStyle() {
    return RecordAmountHeaderStyle.defaultCostStyle().copyWith(
      hintTextStyle: const TextStyle(fontSize: 72, fontWeight: FontWeight.w700, color: Color(0x4c24d900)),
        titleTextStyle: const TextStyle(fontSize: 72, fontWeight: FontWeight.w700, color: Color(0xFF24d900))
    );
  }

  RecordAmountHeaderStyle copyWith({TextStyle hintTextStyle, TextStyle titleTextStyle}) {
    return RecordAmountHeaderStyle(
      hintTextStyle: hintTextStyle ?? this.hintTextStyle,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle
    );
  }
}

class RecordAmountHeader extends StatelessWidget {
  final RecordAmountHeaderViewModel _viewModel;
  final RecordAmountHeaderStyle _style;

  const RecordAmountHeader({Key key, RecordAmountHeaderViewModel viewModel, RecordAmountHeaderStyle style}) : this._viewModel = viewModel, this._style = style, super(key: key);

  static Widget _build(RecordAmountHeaderViewModel viewModel, RecordAmountHeaderStyle style) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32),
      height: 138,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                decoration: InputDecoration(hintText: viewModel.amount, hintStyle: style.hintTextStyle),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: style.titleTextStyle,
                  maxLines: 1
                ),
                 ]
                )
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _build(_viewModel, _style);
  }

}
