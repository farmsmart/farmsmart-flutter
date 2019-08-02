import 'package:farmsmart_flutter/ui/common/ListDivider.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordTransaction.dart';
import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/ui/common/Dogtag.dart';

class ProfitLossListItemViewModel {
  final String title;
  final String subtitle;
  final String detail;

  final RecordTransactionViewModel detailViewModel;
  final DogTagStyle style;

  ProfitLossListItemViewModel(
      {this.title, this.subtitle, this.detail, this.style, this.detailViewModel});
}

class ProfitLossItemStyle {
  final TextStyle titleStyle;
  final TextStyle subtitleStyle;
  final EdgeInsets edgePadding;
  final double elevation;
  final double detailLineSpace;
  final double titleLineSpace;
  final int maxLines;

  ProfitLossItemStyle(
      {this.titleStyle,
      this.subtitleStyle,
      this.edgePadding,
      this.elevation,
      this.detailLineSpace,
      this.titleLineSpace,
      this.maxLines});

  factory ProfitLossItemStyle.defaultStyle() {
    return ProfitLossItemStyle(
        titleStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: Color(0xff767690)),
        subtitleStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.normal,
            color: Color(0xff1a1b46)),
        edgePadding: const EdgeInsets.only(
            left: 32.0, top: 21.3, right: 32.0, bottom: 21.3),
        elevation: 0.0,
        detailLineSpace: 20.5,
        maxLines: 1,
        titleLineSpace: 7);
  }

  ProfitLossItemStyle copyWith(
      {TextStyle titleStyle,
      TextStyle subtitleStyle,
      EdgeInsets edgePadding,
      double elevation,
      double detailLineSpace,
      double titleLineSpace,
      int maxLines}) {
    return ProfitLossItemStyle(
        titleStyle: titleStyle ?? this.titleStyle,
        subtitleStyle: subtitleStyle ?? this.subtitleStyle,
        edgePadding: edgePadding ?? this.edgePadding,
        elevation: elevation ?? this.elevation,
        detailLineSpace: detailLineSpace ?? this.detailLineSpace,
        maxLines: maxLines ?? this.maxLines,
        titleLineSpace: titleLineSpace ?? this.titleLineSpace);
  }
}

class ProfitLossListItem extends StatelessWidget {
  final ProfitLossListItemViewModel _viewModel;
  final ProfitLossItemStyle _style;

  const ProfitLossListItem(
      {Key key,
      ProfitLossListItemViewModel viewModel,
      ProfitLossItemStyle style})
      : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: ()=> _navigateToDetail(context,_viewModel.detailViewModel),
        child: Card(
          margin: EdgeInsets.all(0),
            elevation: _style.elevation,
            child: Column(children: <Widget>[
              Container(
                  padding: _style.edgePadding,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _buildMainTextView(_viewModel, _style),
                        SizedBox(width: _style.detailLineSpace),
                        DogTag(
                          viewModel: DogTagViewModel(number: _viewModel.detail),
                          style: _viewModel.style,
                        )
                      ])),
              ListDivider.build(),
            ])));
  }
}
_navigateToDetail(BuildContext context, RecordTransactionViewModel viewModel) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RecordTransaction(viewModel: viewModel),
      ),
    );
}

_buildMainTextView(
    ProfitLossListItemViewModel viewModel, ProfitLossItemStyle style) {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(viewModel.title,
            style: style.titleStyle,
            maxLines: style.maxLines,
            overflow: TextOverflow.ellipsis),
        SizedBox(height: style.titleLineSpace),
        Text(viewModel.subtitle,
            style: style.subtitleStyle,
            maxLines: style.maxLines,
            overflow: TextOverflow.ellipsis)
      ],
    ),
  );
}
