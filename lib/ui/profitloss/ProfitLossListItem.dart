import 'package:farmsmart_flutter/ui/common/listDivider.dart';
import 'package:farmsmart_flutter/ui/myplot/PlotListItem.dart';
import 'package:farmsmart_flutter/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/ui/common/RoundedBackgroundText.dart';
import 'package:farmsmart_flutter/ui/common/CompactRoundedBackgroundTextStyle.dart';


class ProfitLossItemViewModel {
  final String title;
  final String subTitle;
  final double detail;

  ProfitLossItemViewModel(this.title, this.subTitle, this.detail);
}

ProfitLossItemViewModel buildProfitLossItemViewModel() {
  return ProfitLossItemViewModel("14 May - Crop Rotational", "New equipment for my crop, and new material for a new tomato crop", -250);
}

abstract class ProfitLossItemStyle {

  final TextStyle titleStyle;
  final TextStyle subTitleStyle;


  final EdgeInsets edgePadding;

  final double elevation;
  final double detailLineSpace;
  final double titleLineSpace;
  final int maxLines;


  ProfitLossItemStyle(this.elevation, this.edgePadding, this.detailLineSpace, this.titleStyle, this.maxLines,
      this.titleLineSpace, this.subTitleStyle);

}

class _DefaultStyle implements ProfitLossItemStyle {

  final TextStyle titleStyle = const TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Color(0xff767690));
  final TextStyle subTitleStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Color(0xff1a1b46));

  final EdgeInsets edgePadding = const EdgeInsets.only(left: 32.0, top: 26.0, right: 32.0, bottom: 23.5);

  final double elevation = 0.0;
  final double detailLineSpace = 20.5;
  final int maxLines = 1;
  final double titleLineSpace = 7;

  const _DefaultStyle();
}

class HomeProfitLossChild {
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
                        RoundedBackgroundText.build(
                            style: viewModel.detail >= 0 ? PositiveCompactRoundedBackgroundTextStyle():
                            NegativeCompactBackgroundTextStyle(), title: viewModel.detail.toString())
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
        Text(viewModel.subTitle,
            style: itemStyle.subTitleStyle,
            maxLines: itemStyle.maxLines,
            overflow: TextOverflow.ellipsis)
      ],
    ),
  );
}



