import 'package:farmsmart_flutter/ui/common/listDivider.dart';
import 'package:farmsmart_flutter/ui/myplot/PlotListItem.dart';
import 'package:farmsmart_flutter/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/ui/common/Dogtag.dart';
import 'package:farmsmart_flutter/ui/common/DogTagStyle.dart';


class ProfitLossItemViewModel {
  final String title;
  final String subtitle;

  //TODO:ask for double or Int in transaction number
  final int detail;

  ProfitLossItemViewModel(this.title, this.subtitle, this.detail);
}

ProfitLossItemViewModel buildProfitLossItemViewModel() {
  return ProfitLossItemViewModel("14 May - Crop Rotational", "New equipment for my crop, and new material for a new tomato crop", 250);
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
  Widget buildListItem(ProfitLossItemViewModel viewModel, {ProfitLossItemStyle itemStyle = const _DefaultStyle()}) {
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
                            style: viewModel.detail >= 0 ? PositiveDogTagStyle():
                            NegativeDogTagStyle(), title: viewModel.detail.toString())
                      ])),
              ListDivider.build(),
            ]
            )
        )
    );
  }
}

_buildMainTextView(ProfitLossItemViewModel viewModel, ProfitLossItemStyle itemStyle) {
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



