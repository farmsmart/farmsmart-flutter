
import 'package:flutter/material.dart';

class RecordAmountHeaderViewModel {
  String amount;

  RecordAmountHeaderViewModel(this.amount);
}

class RecordAmountHeaderStyle {
  final TextStyle titleTextStyle;

  RecordAmountHeaderStyle({this.titleTextStyle});

  factory RecordAmountHeaderStyle.defaultCostStyle() {
    return RecordAmountHeaderStyle(
      titleTextStyle: const TextStyle(fontSize: 72, fontWeight: FontWeight.w700, color: Color(0x4cff8d4f))
    );
  }

  factory RecordAmountHeaderStyle.recordCostStyle() {
    return RecordAmountHeaderStyle.defaultCostStyle().copyWith(
        titleTextStyle: const TextStyle(fontSize: 72, fontWeight: FontWeight.w700, color: Color(0xFFff8d4f))
    );
  }

  factory RecordAmountHeaderStyle.recordSaleStyle() {
    return RecordAmountHeaderStyle.defaultCostStyle().copyWith(
      titleTextStyle: const TextStyle(fontSize: 72, fontWeight: FontWeight.w700, color: Color(0xFF24d900)),
    );
  }

  factory RecordAmountHeaderStyle.defaultSaleStyle() {
    return RecordAmountHeaderStyle.defaultCostStyle().copyWith(
      titleTextStyle: const TextStyle(fontSize: 72, fontWeight: FontWeight.w700, color: Color(0xFF24d900)),
    );
  }

  RecordAmountHeaderStyle copyWith({TextStyle titleTextStyle}) {
    return RecordAmountHeaderStyle(
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
                decoration: InputDecoration.collapsed(hintText: viewModel.amount),
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
