import 'package:farmsmart_flutter/ui/common/ListDivider.dart';
import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/ui/common/Dogtag.dart';

class ProfitLossListItemViewModel {
  final String title;
  final String subtitle;
  final String detail;
  final DogTagStyle style;

  ProfitLossListItemViewModel(
      {this.title, this.subtitle, this.detail, this.style});
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
            left: 32.0, top: 26.0, right: 32.0, bottom: 23.5),
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
        //onTap: viewModel.onTap,
        child: Card(
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
