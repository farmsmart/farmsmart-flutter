import 'package:farmsmart_flutter/ui/common/listDivider.dart';
import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/ui/common/Dogtag.dart';
import 'package:farmsmart_flutter/ui/common/DogTagStyle.dart';


class ProfitLossListItemViewModel {
  final String title;
  final String subtitle;
  final String detail;

  ProfitLossListItemViewModel({this.title, this.subtitle, this.detail}) {
  }
}

abstract class ProfitLossItemStyle {

  final TextStyle titleStyle;
  final TextStyle subtitleStyle;


  final EdgeInsets edgePadding;

  final double elevation;
  final double detailLineSpace;
  final double titleLineSpace;
  final int maxLines;


  ProfitLossItemStyle(this.elevation, this.edgePadding, this.detailLineSpace, this.titleStyle, this.maxLines,
      this.titleLineSpace, this.subtitleStyle);

}

class _DefaultStyle implements ProfitLossItemStyle {

  final TextStyle titleStyle = const TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Color(0xff767690));
  final TextStyle subtitleStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Color(0xff1a1b46));

  final EdgeInsets edgePadding = const EdgeInsets.only(left: 32.0, top: 26.0, right: 32.0, bottom: 23.5);

  final double elevation = 0.0;
  final double detailLineSpace = 20.5;
  final int maxLines = 1;
  final double titleLineSpace = 7;

  const _DefaultStyle();
}

class ProfitLossListItem {
  Widget buildListItem(ProfitLossListItemViewModel viewModel, {ProfitLossItemStyle itemStyle = const _DefaultStyle()}) {
    return GestureDetector(
        //onTap: viewModel.onTap,
        child: Card(
            elevation: itemStyle.elevation,
            child: Column(children: <Widget>[
              Container(
                  padding: itemStyle.edgePadding,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _buildMainTextView(viewModel, itemStyle),
                        SizedBox(width: itemStyle.detailLineSpace),
                        DogTag.build(
                            style: PositiveDogTagStyle(),
                            viewModel: DogTagViewModel(number: viewModel.detail))
                      ])),
              ListDivider.build(),
            ]
            )
        )
    );
  }
}

_buildMainTextView(ProfitLossListItemViewModel viewModel, ProfitLossItemStyle itemStyle) {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(viewModel.title,
            style: itemStyle.titleStyle,
            maxLines: itemStyle.maxLines,
            overflow: TextOverflow.ellipsis),
        SizedBox(height: itemStyle.titleLineSpace),
        Text(viewModel.subtitle,
            style: itemStyle.subtitleStyle,
            maxLines: itemStyle.maxLines,
            overflow: TextOverflow.ellipsis)
      ],
    ),
  );
}



